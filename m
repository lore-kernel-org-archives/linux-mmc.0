From: Piotr Sroka <piotrs-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 1/2] [1/2] mmc: sdhci-cadence: Fix writing PHY delay
Date: Thu, 23 Feb 2017 11:46:11 +0000
Message-ID: <DM5PR07MB308274A027F287ABF4408F0ADD530@DM5PR07MB3082.namprd07.prod.outlook.com>
References: <1487250413-5769-1-git-send-email-piotrs@cadence.com>
 <CAK7LNARW4zQ2OutrAfzkigt8OgMbAMbaLvTB2ZNfwbApHT=TEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNARW4zQ2OutrAfzkigt8OgMbAMbaLvTB2ZNfwbApHT=TEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFzYWhpcm8gWWFtYWRh
IFttYWlsdG86eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb21dDQo+IFNlbnQ6IDIzIEZlYnJ1
YXJ5LCAyMDE3IDEyOjI5IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBbMS8yXSBtbWM6
IHNkaGNpLWNhZGVuY2U6IEZpeCB3cml0aW5nIFBIWSBkZWxheQ0KPiANCj4gSGkuDQo+IA0KPiA+
IC1zdGF0aWMgdm9pZCBzZGhjaV9jZG5zX3dyaXRlX3BoeV9yZWcoc3RydWN0IHNkaGNpX2NkbnNf
cHJpdiAqcHJpdiwNCj4gPiArc3RhdGljIGludCBzZGhjaV9jZG5zX3dyaXRlX3BoeV9yZWcoc3Ry
dWN0IHNkaGNpX2NkbnNfcHJpdiAqcHJpdiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdTggYWRkciwgdTggZGF0YSkNCj4gDQo+IA0KPiBJZiB5b3UgaGF2ZSBhIGNo
YW5jZSB0byBzdWJtaXQgdjIsDQo+IEkgd2FudCB0aGUgaW5kZW50IG9mIHRoZSBhYm92ZSBsaW5l
IGFkanVzdGVkLg0KPiANCk9rIHRoYW5rcy4gSSB3aWxsIGZpeCB0aGUgaW5kZW50IGluIHYyLg0K
DQpSZWdhcmRzDQpQaW90ciBTcm9rYQ0KDQo=
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
