From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2 v3] mmc: dw_mmc: Fix the DTO timeout overflow
 calculation for 32-bit systems
Date: Tue, 27 Feb 2018 09:46:39 +0800
Message-ID: <f370f35e-64c4-eaff-e8db-92137fbb29f6@rock-chips.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
 <20180226143413.44134-2-Evgeniy.Didin@synopsys.com>
 <d955cc19-1398-3c05-4742-32664480d07d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <d955cc19-1398-3c05-4742-32664480d07d@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Cj4gCj4gI2RlZmluZSBESVZfUk9VTkRfRE9XTl9VTEwobGwsIGQpIFwKPiAgwqDCoMKgwqAoeyB1
bnNpZ25lZCBsb25nIGxvbmcgX3RtcCA9IChsbCk7IGRvX2RpdihfdG1wLCBkKTsgX3RtcDsgfSkK
PiAKPiAjZGVmaW5lIERJVl9ST1VORF9VUF9VTEwobGwsIGQpwqDCoMKgwqDCoMKgwqAgRElWX1JP
VU5EX0RPV05fVUxMKChsbCkgKyAoZCkgLSAKPiAxLCAoZCkpCj4gCj4gCj4gSXQgdXNlcyBpbnRl
cm1lZGlhdGUgdW5zaWduZWQgbG9uZyBsb25nIF90bXAgZm9yIHlvdXIgIm11bHRpcGx5IiwgbmFt
ZWx5Cj4gTVNFQ19QRVJfU0VDICogZHJ0b19jbGtzICogZHJ0b19kaXYsIHdoaWNoIGNvdWxkIHNv
bHZlcyB0aGUgcHJvYmxlbS4KPiBTbyBJIGRvbid0IHNlZSB3aHkgRElWX1JPVU5EX1VQX1VMTCBj
YW4ndCB3b3JrIGZvciB5b3U/CgpUYWtlIGJhY2suICBJIG1pc3VuZGVyc3Rvb2QgeW91ciAibXVs
dGlwbHkiLCBzb3JyeS4KCj4gCj4gCj4+IMKgwqDCoMKgwqAgLyogYWRkIGEgYml0IHNwYXJlIHRp
bWUgKi8KPj4KPiAKPiAKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1zbnBzLWFyYyBtYWlsaW5nIGxpc3QKbGludXgtc25wcy1hcmNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXNucHMtYXJj
