From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Mon, 2 Jan 2017 11:55:21 +0000
Message-ID: <1483358104.3592.50.camel@sandisk.com>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
         <0fec238b-3c3c-6928-71ec-c3d4bcc6d267@codeaurora.org>
         <CACRpkdazLSk1i37ERs4YwuwXnmbmrnyAX1T5kRXjKcPSaAYd7Q@mail.gmail.com>
         <20161228085503.GA340@lst.de>
         <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <4BB5FBD596AB1B498971FCA90DE3DA68@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
To: "hch@lst.de" <hch@lst.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "baolin.wang@linaro.org" <baolin.wang@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "riteshh@codeaurora.org" <riteshh@codeaurora.org>, "paolo.valente@linaro.org" <paolo.valente@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "zhang.chunyan@linaro.org" <zhang.chunyan@linaro.org>
List-Id: linux-mmc@vger.kernel.org

T24gVGh1LCAyMDE2LTEyLTI5IGF0IDAwOjU5ICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBBIHByb2JsZW0gaGVyZSBpcyB0aGF0IGlzc3VlaW5nIHRoZSByZXF1ZXN0cyBhcmUgaW4gYmxv
Y2tpbmcgY29udGV4dA0KPiB3aGlsZSBjb21wbGV0aW9uIGlzIGluIElSUSBjb250ZXh0IChmb3Ig
bW9zdCBkcml2ZXJzKSBzbyB3ZSBuZWVkIHRvDQo+IGxvb2sgaW50byB0aGlzLg0KDQpIZWxsbyBM
aW51cywNCg0KQWx0aG91Z2ggSSdtIG5vdCBzdXJlIHdoZXRoZXIgSSB1bmRlcnN0b29kIHlvdSBj
b3JyZWN0bHk6IGFyZSB5b3UgZmFtaWxpYXINCndpdGggdGhlIHJlcXVlc3QgcXVldWUgZmxhZyBC
TEtfTVFfRl9CTE9DS0lORywgYSBmbGFnIHRoYXQgd2FzIGludHJvZHVjZWQNCmZvciB0aGUgbmJk
IGRyaXZlcj8NCg0KQmFydC4=
