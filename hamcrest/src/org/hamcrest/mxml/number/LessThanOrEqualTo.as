package org.hamcrest.mxml.number {

    import org.hamcrest.Matcher;
    import org.hamcrest.mxml.BaseMXMLMatcher;
    import org.hamcrest.number.lessThanOrEqualTo;

    public class LessThanOrEqualTo extends BaseMXMLMatcher {

        private var _value:Number;

        public function LessThanOrEqualTo() {
            super();
        }

        [Bindable('valueChanged')]
        public function get value():Number {
            return _value;
        }

        public function set value(value:Number):void {
            if (_value == value) {
                return;
            }

            _value = value;
            changed('value');
        }

        override protected function createMatcher():Matcher {
            return lessThanOrEqualTo(value);
        }
    }
}