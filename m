From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
Date: Fri, 19 Oct 2018 15:44:38 +0200
Message-ID: <e7687ded-bf95-5b76-a56b-99dc27434b8c@suse.de>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
 <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
 <ab70f1dd-6943-9642-aafa-71840fd44f07@kernel.dk>
 <689F28AA-92B5-48B5-BBE7-0B589F163228@linaro.org>
 <7375c004-ac6e-c692-4282-46de554285d5@kernel.dk>
 <20181017100526.GB23493@quack2.suse.cz>
 <d1d082f3-d681-02ed-5bbe-5eb011d6b0da@acm.org>
 <CAHhmqcSb45qePdKsidQcEk7bNeZC5h6Oew-qH=LA7dsQL_uhSg@mail.gmail.com>
 <CACRpkdZZ6RU0aJpUqRn1ndyob1_COhaEs6B9QVRWfa+a60n+Lg@mail.gmail.com>
 <CAHhmqcQinFN9ez5MTRquY0FPaYO2BmOKMn0avy84QPWLK1g2Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHhmqcQinFN9ez5MTRquY0FPaYO2BmOKMn0avy84QPWLK1g2Gg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Bryan Gurney <bgurney@redhat.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>, Artem Bityutskiy <dedekind1@gmail.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Oleksandr Natalenko <oleksandr@natalenko.name>, linux-block <linux-block@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-mmc@vger.kernel.org

T24gMTkvMTAvMTggMTU6MzYsIEJyeWFuIEd1cm5leSB3cm90ZToKPiBJIGxpa2UgdGhpcyBpZGVh
LiAgSSBkb24ndCBoYXZlIGVub3VnaCBleHBlcmllbmNlIHRvIHdyaXRlIHRoaXMgcGF0Y2gKPiBt
eXNlbGYsIGJ1dCBJIGltYWdpbmUgc29tZXRoaW5nIGxpa2UgYWRkaW5nICJib29sIGlzX3pvbmVk
X2F3YXJlIiB0bwo+ICJzdHJ1Y3QgZWxldmF0b3JfdHlwZSIsIGFuZCBzZXR0aW5nIHRoYXQgdHJ1
ZSBvbmx5IGZvciB0aGUgc2NoZWR1bGVycwo+IHRoYXQgYXJlIGN1cnJlbnRseSB6b25lZC1kZXZp
Y2UgYXdhcmUgKHdoaWNoIGlzIGN1cnJlbnRseSBkZWFkbGluZSBvbgo+IHNpbmdsZSBxdWV1ZSwg
bXEtZGVhZGxpbmUgb24gYmxrLW1xKS4KCkkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBuZWVkZWQgY3Vy
cmVudGx5IGFzIGEpIEplbnMgaXMgd29ya2luZyBvbiBnZXR0aW5nCnJpZCBvZiB0aGUgbGVnYWN5
IHBhdGgsIHdoaWNoIGxlYXZlcyB1cyB3aXRoIG1xLWRlYWRsaW5lIG9ubHkgYW5kIExpbnVzJwpw
YXRjaCBoYXM6CgorCWlmIChibGtfcXVldWVfaXNfem9uZWQocSkpCisJCXBvbGljeSA9ICJtcS1k
ZWFkbGluZSI7CgpXaGljaCBjaG9vc2VzIG1xLWRlYWRsaW5lIG9uIGEgem9uZWQgZGV2aWNlLgoK
U28gbm90aGluZyB0byB3b3JyeSBhYm91dCBoZXJlIG5vdy4KCkFsbCB0aGlzIG9ubHkgZ2l2ZW4g
TGludXMnIHBhdGNoIGFjdHVhbGx5IGdldHMgbWVyZ2VkLgoKQnl0ZSwKCUpvaGFubmVzCi0tIApK
b2hhbm5lcyBUaHVtc2hpcm4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
U1VTRSBMYWJzCmp0aHVtc2hpcm5Ac3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKzQ5IDkxMSA3NDA1MyA2ODkKU1VTRSBMSU5VWCBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFuZSBTbWl0aGFyZCwgR3JhaGFt
IE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKS2V5IGZpbmdlcnByaW50ID0gRUMzOCA5
Q0FCIEMyQzQgRjI1RCA4NjAwIEQwRDAgMDM5MyA5NjlEIDJENzYgMDg1MAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBkaXNj
dXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW10ZC8K
