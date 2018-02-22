From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix the DTO timeout overflow calculation
 for 32-bit systems
Date: Thu, 22 Feb 2018 09:38:32 -0800
Message-ID: <afbfa58b-500e-4d65-04a5-f5f26d8e6abe@synopsys.com>
References: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
 <bec45955-1e84-400b-961f-35b5342c671f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <bec45955-1e84-400b-961f-35b5342c671f@rock-chips.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Evgeniy Didin <Evgeniy.Didin@synopsys.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

T24gMDIvMjIvMjAxOCAwNzoyOCBBTSwgU2hhd24gTGluIHdyb3RlOgo+Pgo+PiBMZXRzIGNhc3Qg
dGhpcyBtdWx0aXBseSB0byB1NjQgdHlwZSB3aGljaCBwcmV2ZW50cyBvdmVyZmxvdy4KPj4KPj4g
VGVzdGVkLWJ5OiBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMuY29tPgo+PiBG
aXhlczogQVJDIFNUQVIgOTAwMTMwNjg3MiBIU0RLLCBzZGlvOiBib2FyZCBjcmFzaGVzIHdoZW4g
Y29weWluZyBiaWcgZmlsZXMKPj4KPj4gU2lnbmVkLW9mZi1ieTogRXZnZW5peSBEaWRpbiA8RXZn
ZW5peS5EaWRpbkBzeW5vcHN5cy5jb20+Cj4+Cj4+IENDOiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2Rr
aW5Ac3lub3BzeXMuY29tPgo+PiBDQzogRXVnZW5peSBQYWx0c2V2IDxwYWx0c2V2QHN5bm9wc3lz
LmNvbT4KPj4gQ0M6IERvdWdsYXMgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4KPj4g
Q0M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPgo+PiBDQzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwo+PiBDQzogbGludXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwo+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICPCoCA5ZDk0OTFhN2RhMmEgbW1j
OiBkd19tbWM6IEZpeCB0aGUgRFRPIHRpbWVvdXQgCj4+IGNhbGN1bGF0aW9uCj4gCj4gVGhlIGZp
eCBsb29rcyBnb29kIHRvIG1lLCBidXQgdGhlIHRhZ3Mgc2hvdWxkIGJlIGltcHJvdmVkIGEgYml0
Ogo+IAo+IEZpeGVzOiA5ZDk0OTFhN2RhMmEgKCJtbWM6IGR3X21tYzogRml4IHRoZSBEVE8gdGlt
ZW91dCBjYWxjdWxhdGlvbiIpCgpPaywgdGhlbiBwZXJoYXBzIHVzZSBSZXBvcnRlZC1ieSB0YWcg
dG8gY2FsbCBvdXQgd2hlbi9ob3cgaXNzdWUgd2FzIGZvdW5kLgoKUmVwb3J0ZWQtYnk6IEFSQyBT
VEFSIDkwMDEzMDY4NzIgSFNESywgc2RpbzogYm9hcmQgY3Jhc2hlcyB3aGVuIGNvcHlpbmcgYmln
IGZpbGVzCgo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KPiAKPiBPdGhlcndpc2UsCj4g
UmV2aWV3ZWQtYnk6IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2stY2hpcHMuY29tPgoKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1zbnBzLWFy
YyBtYWlsaW5nIGxpc3QKbGludXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXNucHMtYXJj
