From: ziyuan <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 0/3] Add hardware unbusy interrupt support for dw_mmc
Date: Thu, 7 Mar 2019 16:21:34 +0800
Message-ID: <8d18eac0-d9f9-8785-75f4-bd304b5f3078@rock-chips.com>
References: <1551238603-82412-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1551238603-82412-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

VGhhbmtzIGZvciBxdWlja2x5IHdvcmsgdGhpcyBvdXQsIGl0IHdvcmtzIGZpbmUgYnkgdGVzdGlu
ZyB1bnRpbCBub3csIAphbmQgaXQgcGVyZmFjdGx5IG1ha2UgdGhlIHN5c3RlbSB3b3JrIGJldHRl
ciBpbiBzaW5nbGUgY29yZSBwbGF0Zm9ybS4KClRlc3RlZC1ieTogWml5dWFuIFh1IDx4enkueHVA
cm9jay1jaGlwcy5jb20+CgpPbiAyMDE5LzIvMjcg5LiK5Y2IMTE6MzYsIFNoYXduIExpbiB3cm90
ZToKPiBEZXNpZ25XYXJlIE1NQyBjb250cm9sZXIgbGFja3MgcHJvcGVyIGhhcmR3YXJlIHdhaXQK
PiBidXN5IHN1cHBvcnQsIHNvIHRoZSBzb2Z0d2FyZSBtdXN0IGNoZWNrIHRoZSBidXN5Cj4gc3Rh
dGUgaWYgdGhlIGZvbGxvd2luZyB0cmFuZnNlciBuZWVkIHVzZSBkYXRhIGxpbmUuCj4gQW5kIGR3
X21jaV93YWl0X3doaWxlX2J1c3koKSBub3cgdXNlIGJ1c3kgY2hlY2sgbW9zdGx5Cj4gd2l0aCBo
b3N0J3MgbG9jayBob2xkLCBhbmQgd2UgY2FuJ3QgcmVsaW5ndWlzaCBDUFUKPiBhdCB0aGlzIG1v
bWVudCwgd2hpY2ggbWFrZXMgaXQgcmF0aGVyIHBhaW5mdWwgd2hlbiB1c2VkCj4gaW4gbG93LWVu
ZCBwbGF0Zm9ybS4gVG8gc29sdmUgdGhpcywgUm9ja2NoaXAgaW52ZW50Cj4gYSBuZXcgaGFyZHdh
cmUgdW5idXN5IGludGVycnVwdCBtb2R1bGUsIHdoaWNoIGNvdWxkCj4gZ2VuZXJhdGUgaW50ZXJy
dXB0IGlmIHRoZSBzdGF0ZSBtYWNoaW5lIHJ1bnMgZnJvbQo+IGJ1c3kgc3RhdGUgaW50byBpZGxl
IHN0YXRlLgo+Cj4KPgo+IFNoYXduIExpbiAoMyk6Cj4gICAgbW1jOiBkd19tbWM6IENoZWNrIGJ1
c3kgc3RhdGUgaW4gZHdfbWNpX3JlcXVlc3QoKQo+ICAgIG1tYzogZHdfbW1jOiBBZGQgaGFyZHdh
cmUgdW5idXN5IGludGVycnVwdCBzdXBwb3J0Cj4gICAgbW1jOiBkd19tbWMtcm9ja2NoaXA6IEVu
YWJsZSBoYXJkd2FyZSB1bmJ1c3kgaW50ZXJydXB0IHN1cHBvcnQKPgo+ICAgZHJpdmVycy9tbWMv
aG9zdC9kd19tbWMtcm9ja2NoaXAuYyB8IDMwICsrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZl
cnMvbW1jL2hvc3QvZHdfbW1jLmMgICAgICAgICAgfCA2MCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQo+ICAgZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuaCAgICAgICAgICB8
ICA2ICsrKysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Ci0tIApaaXl1YW4gWHUKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlzdApMaW51eC1yb2NrY2hp
cEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcm9ja2NoaXAK
