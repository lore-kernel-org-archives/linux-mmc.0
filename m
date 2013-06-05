From: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 05/10] mmc: dw_mmc-pltfm: remove static from
 dw_mci_pltfm_remove
Date: Wed, 05 Jun 2013 23:00:26 +0900
Message-ID: <001501ce61f5$08043ba0$180cb2e0$%jun@samsung.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030058.27184.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <201306030058.27184.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: 'Mike Turquette' <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Rob Herring' <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, 'Jaehoon Chung' <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'John Stultz' <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Russell King' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, 'Thomas Gleixner' <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, 'Chris Ball' <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

T24gMDYvMDMvMTMgMjAxMyA3OjU4IEFNLCBIZWlrbyBTdMO8Ym5lciB3cm90ZToKPiBkd19tY2lf
cGx0Zm1fcmVtb3ZlIGdldHMgZXhwb3J0ZWQgYW5kIHVzZWQgYnkgZHdfbW1jLWV4eW5vcywgc28g
c2hvdWxkCj4gbm90IGJlIHN0YXRpYy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTdHVlYm5l
ciA8aGVpa29Ac250ZWNoLmRlPgoKQWNrZWQtYnk6IFNldW5nd29uIEplb24gPHRnaWguanVuQHNh
bXN1bmcuY29tPgoKVGhhbmtzLApTZXVuZ3dvbiBKZW9uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZpY2V0cmVlLWRpc2N1c3MgbWFpbGluZyBsaXN0
CmRldmljZXRyZWUtZGlzY3Vzc0BsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJz
Lm9yZy9saXN0aW5mby9kZXZpY2V0cmVlLWRpc2N1c3MK
