From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface
 support
Date: Mon, 17 Aug 2015 14:27:47 +0800
Message-ID: <55D17EE3.2040700@rock-chips.com>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
 <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
 <1522710.BT6Gc0L6oH@diego>
 <CAD=FV=W1dzqoJuJtJsD5TPKmSBpUbBcifGz654o9x8J1rX6-GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040500050702000108070203"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.133]:56464 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbHQG2D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 02:28:03 -0400
In-Reply-To: <CAD=FV=W1dzqoJuJtJsD5TPKmSBpUbBcifGz654o9x8J1rX6-GQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mips@linux-mips.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>linux

This is a multi-part message in MIME format.
--------------040500050702000108070203
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2015/8/17 5:10, Doug Anderson 写道:
> Heiko,
>
> On Fri, Aug 14, 2015 at 3:13 PM, Heiko Stübner <heiko@sntech.de> wrote:
>> Hi Shawn,
>>
>> Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
>>> DesignWare MMC Controller can supports two types of DMA
>>> mode: external dma and internal dma. We get a RK312x platform
>>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>>> edmac ops to support these platforms. I've tested it on RK312x
>>> platform with edmac mode and RK3288 platform with idmac mode.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> judging by your "from", I guess you're running this on some older Rockchip soc
>> without the idma? Because I tried testing this on a Radxa Rock, but only got
>> failures, from the start (failed to read card status register). In PIO mode
>> everything works again.
>>
>>
>> I guess I overlooked just some tiny detail, but to me the dma channel ids seem
>> correct after all. Maybe you have any hints what I'm doing wrong?
>
> If I were a guessing man (which I'm not), I'd guess that perhaps
> you're running into troubles with our friend the PL330.
>
> There appear to be strange issues with the PL330 on Rockchip SoCs.  I
> was only peripherally involved with them, but I know at least about
> some of the patches in our tree, like:
>

Thanks, Doug, that's the root cause. PL330 on Rockchip Socs need your 
patches, and we might need another patch to limit pl330 burst_len to 
16(Hmm...seems another quirks for rockchip but not on your tree);

Hi Heiko,
I just get a Radxa Rock luckily and test my patch based on 
http://radxa.com/Rock/Linux_Mainline. Yes, it can't work.

If you test my patchset on Rockchip platform, pls apply pl330 patch from 
my tree based on kernel 4.2-RC3. AND, temporary hack dw_mmc to limit 
pl330 burst_len to 16.
This is a dmaengine or pl330 problem(I guest it should be upstreamed 
later?), but my patchset is for *generic* dw_mmc to support emdac, so 
other platforms should never need the hack of pl330.

pl330.patch is for pl330 changes
r3xxx.patch is for pl330 quirks

AND pls limit burst_len to 16 for BROKRN pl330 of rockchips.
static int dw_mci_edmac_start_dma(
...
+        u32 burst_limit = 0;
+        u32 mburst;
+        u32 idx, rx_wmark, tx_wmark;

...
         /* Match burst msize with external dma config */
         fifoth_val = mci_readl(host, FIFOTH);
-	cfg.dst_maxburst = mszs[(fifoth_val >> 28) & 0x7];
-	cfg.src_maxburst = cfg.dst_maxburst;
+	/* HACK for BROKEN pl330 */
+       mburst = mszs[(fifoth_val >> 28) & 0x7];
+       burst_limit = 16;
+       if (mburst > burst_limit) {
+               mburst = burst_limit;
+               idx = (ilog2(mburst) > 0) ? (ilog2(mburst) - 1) : 0;
+               rx_wmark = mszs[idx] - 1;
+               tx_wmark = (host->fifo_depth) / 2;
+               fifoth_val = SDMMC_SET_FIFOTH(idx, rx_wmark, tx_wmark);
+               mci_writel(host, FIFOTH, fifoth_val);
+       }
+	cfg.dst_maxburst = mburst;
+       cfg.src_maxburst = cfg.dst_maxburst;


> https://chromium-review.googlesource.com/237607
> FROMLIST: DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit
>
> https://chromium-review.googlesource.com/237393
> CHROMIUM: dmaengine: pl330: support quirks for some broken
>
> https://chromium-review.googlesource.com/237396
> CHROMIUM: dmaengine: pl330: add quirk for broken no flushp
>
> https://chromium-review.googlesource.com/237394
> CHROMIUM: ARM: dts: rockchip: Add broken-no-flushp into rk3288.dtsi
>
> https://chromium-review.googlesource.com/242063
> CHROMIUM: ASoC: rockchip_i2s: modify DMA max burst to 1
>
>
>


-- 
Shawn Lin

--------------040500050702000108070203
Content-Type: text/plain; charset=UTF-8;
 name="pl330.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pl330.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL3BsMzMwLmMgYi9kcml2ZXJzL2RtYS9wbDMzMC5j
CmluZGV4IGVjYWI0ZWEuLmIyYTk1MGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hL3BsMzMw
LmMKKysrIGIvZHJpdmVycy9kbWEvcGwzMzAuYwpAQCAtMzQsNiArMzQsMTQgQEAKICNkZWZp
bmUgUEwzMzBfTUFYX0lSUVMJCTMyCiAjZGVmaW5lIFBMMzMwX01BWF9QRVJJCQkzMgogCisj
ZGVmaW5lIFBMMzMwX1FVSVJLX0JST0tFTl9OT19GTFVTSFAgQklUKDApCisKK2VudW0gcGwz
MzBfY29uZCB7CisJU0lOR0xFLAorCUJVUlNULAorCUFMV0FZUywKK307CisKIGVudW0gcGwz
MzBfY2FjaGVjdHJsIHsKIAlDQ1RSTDAsCQkvKiBOb25jYWNoZWFibGUgYW5kIG5vbmJ1ZmZl
cmFibGUgKi8KIAlDQ1RSTDEsCQkvKiBCdWZmZXJhYmxlIG9ubHkgKi8KQEAgLTM0NCwxMiAr
MzUyLDYgQEAgZW51bSBwbDMzMF9kc3QgewogCURTVCwKIH07CiAKLWVudW0gcGwzMzBfY29u
ZCB7Ci0JU0lOR0xFLAotCUJVUlNULAotCUFMV0FZUywKLX07Ci0KIHN0cnVjdCBkbWFfcGwz
MzBfZGVzYzsKIAogc3RydWN0IF9wbDMzMF9yZXEgewpAQCAtNDg4LDYgKzQ5MCwxNyBAQCBz
dHJ1Y3QgcGwzMzBfZG1hYyB7CiAJLyogUGVyaXBoZXJhbCBjaGFubmVscyBjb25uZWN0ZWQg
dG8gdGhpcyBETUFDICovCiAJdW5zaWduZWQgaW50IG51bV9wZXJpcGhlcmFsczsKIAlzdHJ1
Y3QgZG1hX3BsMzMwX2NoYW4gKnBlcmlwaGVyYWxzOyAvKiBrZWVwIGF0IGVuZCAqLworCWlu
dCBxdWlya3M7Cit9OworCitzdGF0aWMgc3RydWN0IHBsMzMwX29mX3F1aXJrcyB7CisJY2hh
ciAqcXVpcms7CisJaW50IGlkOworfSBvZl9xdWlya3NbXSA9IHsKKwl7CisJCS5xdWlyayA9
ICJicm9rZW4tbm8tZmx1c2hwIiwKKwkJLmlkID0gUEwzMzBfUVVJUktfQlJPS0VOX05PX0ZM
VVNIUCwKKwl9CiB9OwogCiBzdHJ1Y3QgZG1hX3BsMzMwX2Rlc2MgewpAQCAtMTEzNyw0NyAr
MTE1MCw2NCBAQCBzdGF0aWMgaW5saW5lIGludCBfbGRzdF9tZW10b21lbSh1bnNpZ25lZCBk
cnlfcnVuLCB1OCBidWZbXSwKIAlyZXR1cm4gb2ZmOwogfQogCi1zdGF0aWMgaW5saW5lIGlu
dCBfbGRzdF9kZXZ0b21lbSh1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKK3N0YXRpYyBp
bmxpbmUgaW50IF9sZHN0X2RldnRvbWVtKHN0cnVjdCBwbDMzMF9kbWFjICpwaSx1bnNpZ25l
ZCBkcnlfcnVuLCB1OCBidWZbXSwKIAkJY29uc3Qgc3RydWN0IF94ZmVyX3NwZWMgKnB4cywg
aW50IGN5YykKIHsKIAlpbnQgb2ZmID0gMDsKKwllbnVtIHBsMzMwX2NvbmQgY29uZDsKKwor
CWlmIChwaS0+cXVpcmtzICYgUEwzMzBfUVVJUktfQlJPS0VOX05PX0ZMVVNIUCkKKwkJY29u
ZCA9IEJVUlNUOworCWVsc2UKKwkJY29uZCA9IChweHMtPmRlc2MtPnJxY2ZnLmJyc3RfbGVu
ID09IDEpID8gU0lOR0xFIDogQlVSU1Q7CiAKIAl3aGlsZSAoY3ljLS0pIHsKLQkJb2ZmICs9
IF9lbWl0X1dGUChkcnlfcnVuLCAmYnVmW29mZl0sIFNJTkdMRSwgcHhzLT5kZXNjLT5wZXJp
KTsKLQkJb2ZmICs9IF9lbWl0X0xEUChkcnlfcnVuLCAmYnVmW29mZl0sIFNJTkdMRSwgcHhz
LT5kZXNjLT5wZXJpKTsKKwkJb2ZmICs9IF9lbWl0X1dGUChkcnlfcnVuLCAmYnVmW29mZl0s
IGNvbmQsIHB4cy0+ZGVzYy0+cGVyaSk7CisJCW9mZiArPSBfZW1pdF9MRFAoZHJ5X3J1biwg
JmJ1ZltvZmZdLCBjb25kLCBweHMtPmRlc2MtPnBlcmkpOwogCQlvZmYgKz0gX2VtaXRfU1Qo
ZHJ5X3J1biwgJmJ1ZltvZmZdLCBBTFdBWVMpOwotCQlvZmYgKz0gX2VtaXRfRkxVU0hQKGRy
eV9ydW4sICZidWZbb2ZmXSwgcHhzLT5kZXNjLT5wZXJpKTsKKworCQlpZiAoIShwaS0+cXVp
cmtzICYgUEwzMzBfUVVJUktfQlJPS0VOX05PX0ZMVVNIUCkpCisJCQlvZmYgKz0gX2VtaXRf
RkxVU0hQKGRyeV9ydW4sICZidWZbb2ZmXSwgcHhzLT5kZXNjLT5wZXJpKTsKIAl9CiAKIAly
ZXR1cm4gb2ZmOwogfQogCi1zdGF0aWMgaW5saW5lIGludCBfbGRzdF9tZW10b2Rldih1bnNp
Z25lZCBkcnlfcnVuLCB1OCBidWZbXSwKK3N0YXRpYyBpbmxpbmUgaW50IF9sZHN0X21lbXRv
ZGV2KHN0cnVjdCBwbDMzMF9kbWFjICpwaSwgdW5zaWduZWQgZHJ5X3J1biwgdTggYnVmW10s
CiAJCWNvbnN0IHN0cnVjdCBfeGZlcl9zcGVjICpweHMsIGludCBjeWMpCiB7CiAJaW50IG9m
ZiA9IDA7CisJZW51bSBwbDMzMF9jb25kIGNvbmQ7CisKKwlpZiAocGktPnF1aXJrcyAmIFBM
MzMwX1FVSVJLX0JST0tFTl9OT19GTFVTSFApCisJCWNvbmQgPSBCVVJTVDsKKwllbHNlCisJ
CWNvbmQgPSAocHhzLT5kZXNjLT5ycWNmZy5icnN0X2xlbiA9PSAxKSA/IFNJTkdMRSA6IEJV
UlNUOworCiAKIAl3aGlsZSAoY3ljLS0pIHsKLQkJb2ZmICs9IF9lbWl0X1dGUChkcnlfcnVu
LCAmYnVmW29mZl0sIFNJTkdMRSwgcHhzLT5kZXNjLT5wZXJpKTsKKwkJb2ZmICs9IF9lbWl0
X1dGUChkcnlfcnVuLCAmYnVmW29mZl0sIGNvbmQsIHB4cy0+ZGVzYy0+cGVyaSk7CiAJCW9m
ZiArPSBfZW1pdF9MRChkcnlfcnVuLCAmYnVmW29mZl0sIEFMV0FZUyk7Ci0JCW9mZiArPSBf
ZW1pdF9TVFAoZHJ5X3J1biwgJmJ1ZltvZmZdLCBTSU5HTEUsIHB4cy0+ZGVzYy0+cGVyaSk7
Ci0JCW9mZiArPSBfZW1pdF9GTFVTSFAoZHJ5X3J1biwgJmJ1ZltvZmZdLCBweHMtPmRlc2Mt
PnBlcmkpOworCQlvZmYgKz0gX2VtaXRfU1RQKGRyeV9ydW4sICZidWZbb2ZmXSwgY29uZCwg
cHhzLT5kZXNjLT5wZXJpKTsKKworCQlpZiAoIShwaS0+cXVpcmtzICYgUEwzMzBfUVVJUktf
QlJPS0VOX05PX0ZMVVNIUCkpCQkKKwkJCW9mZiArPSBfZW1pdF9GTFVTSFAoZHJ5X3J1biwg
JmJ1ZltvZmZdLCBweHMtPmRlc2MtPnBlcmkpOwogCX0KIAogCXJldHVybiBvZmY7CiB9CiAK
LXN0YXRpYyBpbnQgX2J1cnN0cyh1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKK3N0YXRp
YyBpbnQgX2J1cnN0cyhzdHJ1Y3QgcGwzMzBfZG1hYyAqcGksdW5zaWduZWQgZHJ5X3J1biwg
dTggYnVmW10sCiAJCWNvbnN0IHN0cnVjdCBfeGZlcl9zcGVjICpweHMsIGludCBjeWMpCiB7
CiAJaW50IG9mZiA9IDA7CiAKIAlzd2l0Y2ggKHB4cy0+ZGVzYy0+cnF0eXBlKSB7CiAJY2Fz
ZSBETUFfTUVNX1RPX0RFVjoKLQkJb2ZmICs9IF9sZHN0X21lbXRvZGV2KGRyeV9ydW4sICZi
dWZbb2ZmXSwgcHhzLCBjeWMpOworCQlvZmYgKz0gX2xkc3RfbWVtdG9kZXYocGksIGRyeV9y
dW4sICZidWZbb2ZmXSwgcHhzLCBjeWMpOwogCQlicmVhazsKIAljYXNlIERNQV9ERVZfVE9f
TUVNOgotCQlvZmYgKz0gX2xkc3RfZGV2dG9tZW0oZHJ5X3J1biwgJmJ1ZltvZmZdLCBweHMs
IGN5Yyk7CisJCW9mZiArPSBfbGRzdF9kZXZ0b21lbShwaSwgZHJ5X3J1biwgJmJ1ZltvZmZd
LCBweHMsIGN5Yyk7CiAJCWJyZWFrOwogCWNhc2UgRE1BX01FTV9UT19NRU06CiAJCW9mZiAr
PSBfbGRzdF9tZW10b21lbShkcnlfcnVuLCAmYnVmW29mZl0sIHB4cywgY3ljKTsKQEAgLTEx
OTEsNyArMTIyMSw3IEBAIHN0YXRpYyBpbnQgX2J1cnN0cyh1bnNpZ25lZCBkcnlfcnVuLCB1
OCBidWZbXSwKIH0KIAogLyogUmV0dXJucyBieXRlcyBjb25zdW1lZCBhbmQgdXBkYXRlcyBi
dXJzdHMgKi8KLXN0YXRpYyBpbmxpbmUgaW50IF9sb29wKHVuc2lnbmVkIGRyeV9ydW4sIHU4
IGJ1ZltdLAorc3RhdGljIGlubGluZSBpbnQgX2xvb3Aoc3RydWN0IHBsMzMwX2RtYWMgKnBp
LCB1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKIAkJdW5zaWduZWQgbG9uZyAqYnVyc3Rz
LCBjb25zdCBzdHJ1Y3QgX3hmZXJfc3BlYyAqcHhzKQogewogCWludCBjeWMsIGN5Y21heCwg
c3pscCwgc3pscGVuZCwgc3picnN0LCBvZmY7CkBAIC0xMjE0LDcgKzEyNDQsNyBAQCBzdGF0
aWMgaW5saW5lIGludCBfbG9vcCh1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKIAl9CiAK
IAlzemxwID0gX2VtaXRfTFAoMSwgYnVmLCAwLCAwKTsKLQlzemJyc3QgPSBfYnVyc3RzKDEs
IGJ1ZiwgcHhzLCAxKTsKKwlzemJyc3QgPSBfYnVyc3RzKHBpLCAxLCBidWYsIHB4cywgMSk7
CiAKIAlscGVuZC5jb25kID0gQUxXQVlTOwogCWxwZW5kLmZvcmV2ZXIgPSBmYWxzZTsKQEAg
LTEyNDYsNyArMTI3Niw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9sb29wKHVuc2lnbmVkIGRy
eV9ydW4sIHU4IGJ1ZltdLAogCW9mZiArPSBfZW1pdF9MUChkcnlfcnVuLCAmYnVmW29mZl0s
IDEsIGxjbnQxKTsKIAlsam1wMSA9IG9mZjsKIAotCW9mZiArPSBfYnVyc3RzKGRyeV9ydW4s
ICZidWZbb2ZmXSwgcHhzLCBjeWMpOworCW9mZiArPSBfYnVyc3RzKHBpLCBkcnlfcnVuLCAm
YnVmW29mZl0sIHB4cywgY3ljKTsKIAogCWxwZW5kLmNvbmQgPSBBTFdBWVM7CiAJbHBlbmQu
Zm9yZXZlciA9IGZhbHNlOwpAQCAtMTI2OSw3ICsxMjk5LDcgQEAgc3RhdGljIGlubGluZSBp
bnQgX2xvb3AodW5zaWduZWQgZHJ5X3J1biwgdTggYnVmW10sCiAJcmV0dXJuIG9mZjsKIH0K
IAotc3RhdGljIGlubGluZSBpbnQgX3NldHVwX2xvb3BzKHVuc2lnbmVkIGRyeV9ydW4sIHU4
IGJ1ZltdLAorc3RhdGljIGlubGluZSBpbnQgX3NldHVwX2xvb3BzKHN0cnVjdCBwbDMzMF9k
bWFjICpwaSwgdW5zaWduZWQgZHJ5X3J1biwgdTggYnVmW10sCiAJCWNvbnN0IHN0cnVjdCBf
eGZlcl9zcGVjICpweHMpCiB7CiAJc3RydWN0IHBsMzMwX3hmZXIgKnggPSAmcHhzLT5kZXNj
LT5weDsKQEAgLTEyNzksMTQgKzEzMDksMTQgQEAgc3RhdGljIGlubGluZSBpbnQgX3NldHVw
X2xvb3BzKHVuc2lnbmVkIGRyeV9ydW4sIHU4IGJ1ZltdLAogCiAJd2hpbGUgKGJ1cnN0cykg
ewogCQljID0gYnVyc3RzOwotCQlvZmYgKz0gX2xvb3AoZHJ5X3J1biwgJmJ1ZltvZmZdLCAm
YywgcHhzKTsKKwkJb2ZmICs9IF9sb29wKHBpLCBkcnlfcnVuLCAmYnVmW29mZl0sICZjLCBw
eHMpOwogCQlidXJzdHMgLT0gYzsKIAl9CiAKIAlyZXR1cm4gb2ZmOwogfQogCi1zdGF0aWMg
aW5saW5lIGludCBfc2V0dXBfeGZlcih1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKK3N0
YXRpYyBpbmxpbmUgaW50IF9zZXR1cF94ZmVyKHN0cnVjdCBwbDMzMF9kbWFjICpwaSx1bnNp
Z25lZCBkcnlfcnVuLCB1OCBidWZbXSwKIAkJY29uc3Qgc3RydWN0IF94ZmVyX3NwZWMgKnB4
cykKIHsKIAlzdHJ1Y3QgcGwzMzBfeGZlciAqeCA9ICZweHMtPmRlc2MtPnB4OwpAQCAtMTI5
OCw3ICsxMzI4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgX3NldHVwX3hmZXIodW5zaWduZWQg
ZHJ5X3J1biwgdTggYnVmW10sCiAJb2ZmICs9IF9lbWl0X01PVihkcnlfcnVuLCAmYnVmW29m
Zl0sIERBUiwgeC0+ZHN0X2FkZHIpOwogCiAJLyogU2V0dXAgTG9vcChzKSAqLwotCW9mZiAr
PSBfc2V0dXBfbG9vcHMoZHJ5X3J1biwgJmJ1ZltvZmZdLCBweHMpOworCW9mZiArPSBfc2V0
dXBfbG9vcHMocGksIGRyeV9ydW4sICZidWZbb2ZmXSwgcHhzKTsKIAogCXJldHVybiBvZmY7
CiB9CkBAIC0xMzA3LDcgKzEzMzcsNyBAQCBzdGF0aWMgaW5saW5lIGludCBfc2V0dXBfeGZl
cih1bnNpZ25lZCBkcnlfcnVuLCB1OCBidWZbXSwKICAqIEEgcmVxIGlzIGEgc2VxdWVuY2Ug
b2Ygb25lIG9yIG1vcmUgeGZlciB1bml0cy4KICAqIFJldHVybnMgdGhlIG51bWJlciBvZiBi
eXRlcyB0YWtlbiB0byBzZXR1cCB0aGUgTUMgZm9yIHRoZSByZXEuCiAgKi8KLXN0YXRpYyBp
bnQgX3NldHVwX3JlcSh1bnNpZ25lZCBkcnlfcnVuLCBzdHJ1Y3QgcGwzMzBfdGhyZWFkICp0
aHJkLAorc3RhdGljIGludCBfc2V0dXBfcmVxKHN0cnVjdCBwbDMzMF9kbWFjICpwaSx1bnNp
Z25lZCBkcnlfcnVuLCBzdHJ1Y3QgcGwzMzBfdGhyZWFkICp0aHJkLAogCQl1bnNpZ25lZCBp
bmRleCwgc3RydWN0IF94ZmVyX3NwZWMgKnB4cykKIHsKIAlzdHJ1Y3QgX3BsMzMwX3JlcSAq
cmVxID0gJnRocmQtPnJlcVtpbmRleF07CkBAIC0xMzI1LDcgKzEzNTUsNyBAQCBzdGF0aWMg
aW50IF9zZXR1cF9yZXEodW5zaWduZWQgZHJ5X3J1biwgc3RydWN0IHBsMzMwX3RocmVhZCAq
dGhyZCwKIAlpZiAoeC0+Ynl0ZXMgJSAoQlJTVF9TSVpFKHB4cy0+Y2NyKSAqIEJSU1RfTEVO
KHB4cy0+Y2NyKSkpCiAJCXJldHVybiAtRUlOVkFMOwogCi0Jb2ZmICs9IF9zZXR1cF94ZmVy
KGRyeV9ydW4sICZidWZbb2ZmXSwgcHhzKTsKKwlvZmYgKz0gX3NldHVwX3hmZXIocGksIGRy
eV9ydW4sICZidWZbb2ZmXSwgcHhzKTsKIAogCS8qIERNQVNFViBwZXJpcGhlcmFsL2V2ZW50
ICovCiAJb2ZmICs9IF9lbWl0X1NFVihkcnlfcnVuLCAmYnVmW29mZl0sIHRocmQtPmV2KTsK
QEAgLTE0MTksNyArMTQ0OSw3IEBAIHN0YXRpYyBpbnQgcGwzMzBfc3VibWl0X3JlcShzdHJ1
Y3QgcGwzMzBfdGhyZWFkICp0aHJkLAogCXhzLmRlc2MgPSBkZXNjOwogCiAJLyogRmlyc3Qg
ZHJ5IHJ1biB0byBjaGVjayBpZiByZXEgaXMgYWNjZXB0YWJsZSAqLwotCXJldCA9IF9zZXR1
cF9yZXEoMSwgdGhyZCwgaWR4LCAmeHMpOworCXJldCA9IF9zZXR1cF9yZXEocGwzMzAsIDEs
IHRocmQsIGlkeCwgJnhzKTsKIAlpZiAocmV0IDwgMCkKIAkJZ290byB4ZmVyX2V4aXQ7CiAK
QEAgLTE0MzMsNyArMTQ2Myw3IEBAIHN0YXRpYyBpbnQgcGwzMzBfc3VibWl0X3JlcShzdHJ1
Y3QgcGwzMzBfdGhyZWFkICp0aHJkLAogCS8qIEhvb2sgdGhlIHJlcXVlc3QgKi8KIAl0aHJk
LT5sc3RlbnEgPSBpZHg7CiAJdGhyZC0+cmVxW2lkeF0uZGVzYyA9IGRlc2M7Ci0JX3NldHVw
X3JlcSgwLCB0aHJkLCBpZHgsICZ4cyk7CisJX3NldHVwX3JlcShwbDMzMCwgMCwgdGhyZCwg
aWR4LCAmeHMpOwogCiAJcmV0ID0gMDsKIApAQCAtMjU1Nyw3ICsyNTg3LDcgQEAgc3RhdGlj
IHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVzY3JpcHRvciAqcGwzMzBfcHJlcF9kbWFfY3ljbGlj
KAogCiAJCWRlc2MtPnJxdHlwZSA9IGRpcmVjdGlvbjsKIAkJZGVzYy0+cnFjZmcuYnJzdF9z
aXplID0gcGNoLT5idXJzdF9zejsKLQkJZGVzYy0+cnFjZmcuYnJzdF9sZW4gPSAxOworCQlk
ZXNjLT5ycWNmZy5icnN0X2xlbiA9IHBjaC0+YnVyc3RfbGVuOwogCQlkZXNjLT5ieXRlc19y
ZXF1ZXN0ZWQgPSBwZXJpb2RfbGVuOwogCQlmaWxsX3B4KCZkZXNjLT5weCwgZHN0LCBzcmMs
IHBlcmlvZF9sZW4pOwogCkBAIC0yNzAyLDcgKzI3MzIsNyBAQCBwbDMzMF9wcmVwX3NsYXZl
X3NnKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2wsCiAJ
CX0KIAogCQlkZXNjLT5ycWNmZy5icnN0X3NpemUgPSBwY2gtPmJ1cnN0X3N6OwotCQlkZXNj
LT5ycWNmZy5icnN0X2xlbiA9IDE7CisJCWRlc2MtPnJxY2ZnLmJyc3RfbGVuID0gcGNoLT5i
dXJzdF9sZW47CiAJCWRlc2MtPnJxdHlwZSA9IGRpcmVjdGlvbjsKIAkJZGVzYy0+Ynl0ZXNf
cmVxdWVzdGVkID0gc2dfZG1hX2xlbihzZyk7CiAJfQpAQCAtMjc3OCw2ICsyODA4LDcgQEAg
cGwzMzBfcHJvYmUoc3RydWN0IGFtYmFfZGV2aWNlICphZGV2LCBjb25zdCBzdHJ1Y3QgYW1i
YV9pZCAqaWQpCiAJc3RydWN0IHJlc291cmNlICpyZXM7CiAJaW50IGksIHJldCwgaXJxOwog
CWludCBudW1fY2hhbjsKKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gYWRldi0+ZGV2Lm9m
X25vZGU7CiAKIAlwZGF0ID0gZGV2X2dldF9wbGF0ZGF0YSgmYWRldi0+ZGV2KTsKIApAQCAt
Mjc5Nyw2ICsyODI4LDExIEBAIHBsMzMwX3Byb2JlKHN0cnVjdCBhbWJhX2RldmljZSAqYWRl
diwgY29uc3Qgc3RydWN0IGFtYmFfaWQgKmlkKQogCiAJcGwzMzAtPm1jYnVmc3ogPSBwZGF0
ID8gcGRhdC0+bWNidWZfc3ogOiAwOwogCisJLyogZ2V0IHF1aXJrICovCisJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUob2ZfcXVpcmtzKTsgaSsrKQorCQlpZiAob2ZfcHJvcGVydHlf
cmVhZF9ib29sKG5wLCBvZl9xdWlya3NbaV0ucXVpcmspKQorCQkJcGwzMzAtPnF1aXJrcyB8
PSBvZl9xdWlya3NbaV0uaWQ7CisKIAlyZXMgPSAmYWRldi0+cmVzOwogCXBsMzMwLT5iYXNl
ID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZhZGV2LT5kZXYsIHJlcyk7CiAJaWYgKElTX0VS
UihwbDMzMC0+YmFzZSkpCg==
--------------040500050702000108070203
Content-Type: text/plain; charset=UTF-8;
 name="rk3xxxx.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="rk3xxxx.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3JrM3h4eC5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvcmszeHh4LmR0c2kKaW5kZXggYTJhZTlmMy4uZmI1YjRlYyAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvcmszeHh4LmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvcmszeHh4LmR0c2kKQEAgLTk0LDYgKzk0LDcgQEAKIAogCQlkbWFjMjogZG1hLWNvbnRy
b2xsZXJAMjAwNzgwMDAgewogCQkJY29tcGF0aWJsZSA9ICJhcm0scGwzMzAiLCAiYXJtLHBy
aW1lY2VsbCI7CisJCQlicm9rZW4tbm8tZmx1c2hwOwogCQkJcmVnID0gPDB4MjAwNzgwMDAg
MHg0MDAwPjsKIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyIElSUV9UWVBFX0xFVkVMX0hJ
R0g+LAogCQkJCSAgICAgPEdJQ19TUEkgMyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsK
--------------040500050702000108070203--

