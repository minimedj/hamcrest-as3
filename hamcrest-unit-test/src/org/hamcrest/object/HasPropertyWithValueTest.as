package org.hamcrest.object {

    import org.hamcrest.AbstractMatcherTestCase;
    import org.hamcrest.core.anything;

    public class HasPropertyWithValueTest extends AbstractMatcherTestCase {

        private var shouldMatch:Object;
        private var shouldNotMatch:Object;

        [Before]
        public function setup():void {
            shouldMatch = new PropertyTester("is expected");
            shouldNotMatch = new PropertyTester("not expected");
        }

        [Test]
        public function matchesObjectWithMatchedNamedProperty():void {
            assertMatches("with property",
                hasPropertyWithValue("property", equalTo("is expected")),
                shouldMatch);

            assertMismatch('property "property" was "not expected"',
                hasPropertyWithValue("property", equalTo("is expected")),
                shouldNotMatch);
        }

        [Test]
        public function doesNotMatchObjectWithoutNamedProperty():void {
            assertMismatch('No property "nonExistantProperty"',
                hasPropertyWithValue("nonExistantProperty", anything()),
                shouldNotMatch);
        }

        [Ignore]
        [Test]
        public function doesNotMatchWriteOnlyProperty():void {
            assertMismatch('property "writeOnlyProperty" is not readable',
                hasPropertyWithValue("writeOnlyProperty", anything()),
                shouldNotMatch);
        }

        [Test]
        public function describeTo():void {
            assertDescription('has property "property" with value <true>',
                hasPropertyWithValue("property", equalTo(true)));
        }

        [Test]
        public function describesMissingPropertyMismatch():void {
            assertMismatch('No property "honk"', hasPropertyWithValue("honk", anything()), shouldNotMatch);
        }

        [Test]
        public function evaluatesToTrueIfArgumentHasOwnProperty():void {

            assertMatches("has property",
                hasPropertyWithValue("value", equalTo("one")),
                { value: "one" });

            assertDoesNotMatch("does not have property",
                hasPropertyWithValue("value", equalTo(false)),
                { other: true });
        }

        [Test]
        public function hasAReadableDescription():void {

            assertDescription('has property "value" with value <3>',
                hasPropertyWithValue("value", equalTo(3)));
        }
    }
}

internal class PropertyTester {

    private var _property:String;

    public function PropertyTester(value:String) {
        _property = value;
    }

    public function get property():String {
        return _property;
    }

    public function set property(value:String):void {
        _property = value;
    }

    public function set writeOnlyProperty(value:Number):void {
        ;
    }
}