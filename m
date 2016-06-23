From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] Documentation: mmc: add description for new caps
Date: Wed, 22 Jun 2016 21:33:35 -0700
Message-ID: <CAD=FV=UC0V1ALZw-EsJXUQ8eVbFY5OppfOGZxMcexSE3B+1EwQ@mail.gmail.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
 <1465374021-2526-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WNaTEDyVNyteLq3O-BL9KxR49W=44jbXogKXd2dkDWDQ@mail.gmail.com>
 <b479bc81-f72f-b4c0-b9eb-c8fc4dd71fbb@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <b479bc81-f72f-b4c0-b9eb-c8fc4dd71fbb-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SGksCgpPbiBXZWQsIEp1biAyMiwgMjAxNiBhdCA2OjI5IFBNLCBTaGF3biBMaW4gPHNoYXduLmxp
bkByb2NrLWNoaXBzLmNvbT4gd3JvdGU6Cj4g5ZyoIDIwMTYvNi8yMiAyMzowNiwgRG91ZyBBbmRl
cnNvbiDlhpnpgZM6Cj4+Cj4+IEhpLAo+Pgo+PiBPbiBXZWQsIEp1biA4LCAyMDE2IGF0IDE6MjAg
QU0sIFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPgo+PiB3cm90ZToKPj4+Cj4+
PiBMZXQncyBhZGQgc29tZSBiYXNpYyBkZXNjcmlwdGlvbiBmb3IgY2FwLW5vLXNkaW8sCj4+PiBj
YXAtbm8tc2QgYW5kIGNhcC1uby1tbWMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU2hhd24gTGlu
IDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+Cj4+Pgo+Pj4gLS0tCj4+Pgo+Pj4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbW1jLnR4dCB8IDMgKysrCj4+PiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21tYy50eHQKPj4+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tbWMudHh0Cj4+PiBpbmRleCBlY2MwMDdhLi5lMTZkNDJi
IDEwMDY0NAo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9t
bWMudHh0Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21t
Yy50eHQKPj4+IEBAIC0zOSw2ICszOSw5IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6Cj4+PiAgLSBj
YXAtcG93ZXItb2ZmLWNhcmQ6IHBvd2VyaW5nIG9mZiB0aGUgY2FyZCBpcyBzYWZlCj4+PiAgLSBj
YXAtbW1jLWh3LXJlc2V0OiBlTU1DIGhhcmR3YXJlIHJlc2V0IGlzIHN1cHBvcnRlZAo+Pj4gIC0g
Y2FwLXNkaW8taXJxOiBlbmFibGUgU0RJTyBJUlEgc2lnbmFsbGluZyBvbiB0aGlzIGludGVyZmFj
ZQo+Pj4gKy0gY2FwLW5vLXNkaW86IHNraXAgc2VuZGluZyBzZGlvIGNtZCBkdXJpbmcgaW5pdGlh
bGl6YXRpb24KPj4+ICstIGNhcC1uby1zZDogc2tpcCBzZW5kaW5nIHNkIGNtZCBkdXJpbmcgaW5p
dGlhbGl6YXRpb24KPj4+ICstIGNhcC1uby1tbWM6IHNraXAgc2VuZGluZyBtbWMgY21kIGR1cmlu
ZyBpbml0aWFsaXphdGlvbgo+Pgo+Pgo+PiBJbiB0aGUgcGFzdCBpdCBoYXMgYmVlbiBkZXRlcm1p
bmVkIHRoYXQgdGhlICJjYXAtIiBwcmVmaXggaXMKPj4gdW5uZWNlc3NhcnkuICBTb21lIHByb3Bl
cnRpZXMgc3RpbGwgaGF2ZSAiY2FwLSIgYmVjYXVzZSBvZiBiYWNrd2FyZAo+PiBjb21wYXRpYmls
aXR5IHJlYXNvbnMsIGJ1dCBhcyBJIHVuZGVyc3RhbmQgaXQgbmV3IHByb3BlcnRpZXMgc2hvdWxk
bid0Cj4+IHN0YXJ0IHdpdGggImNhcC0iLgo+Pgo+PiBTZWUKPj4gPGh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9waXBlcm1haWwvZGV2aWNldHJlZS1kaXNjdXNzLzIwMTMtSnVuZS8wMzQ2NjQuaHRt
bD4KPj4gZm9yIHJlZmVyZW5jZS4KPj4KPgo+IFJlYWxseT8gIHdhcyB0aGF0IHRoZSBmaW5hbCBk
ZWNpc2lvbj8gSSBqdXN0IHNlZSBPbG9mIGNvbXBsYWluZWQgaXQgYnV0Cj4gZG9uJ3Qgc2VlIG90
aGVyIGNvbW1lbnRzIGZyb20gZHQgbWFpbnRhaW5lciBvciBmcm9tIG1tYwo+IG1haW50YWluZXIo
Q2hyaXMgQmFsbCk/Cj4KPiBIaSBVbGYgYW5kIFJvYiwKPgo+IFdoYXQgaXMgeW91ciBvcGluaW9u
PwoKTm90aWNlIHRoYXQgbW9zdCB0aGluZ3MgYWRkZWQgbGF0ZXIgKGxpa2UgbW1jLWhzMjAwLTFf
OHYpIGRvbid0IGhhdmUgImNhcC0iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2NoaXBA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
