Received: from mail-m49242.qiye.163.com (mail-m49242.qiye.163.com [45.254.49.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21851D5CDE;
	Fri, 19 Dec 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766108846; cv=none; b=fgEUTb7Bdlxx63vT9ATzaY/mt/smdDKAwB+R+lss6o/RU+HYoK+jsd37EUveEzmsj5AGl0Pna+L/DWTn6S4k8NL0ebY3itfxEShqKPcoeW5HVTslYfLLTkyFGDjtdWv3SHo5kZrZE1dFhjgf4ucykNZ01wxftN1GSjlqmofqcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766108846; c=relaxed/simple;
	bh=sy+xCOsFREztLBVmFyRluoi2JrZ05T5tVUDh0m1GvuQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To; b=ZsvkjSNmt9vXjSZI+E/thtdIfFugq+DF8pzhIaC4SciSAHjFx9q1uoBFlAt3oqFX3D7H2Y4NpYct+aCempLu04jj1GGcKWBzNdHnLK2rF1XhkeGdS86izFwpVMueQb4skzS0wZRLNFFLLE4ssxToQqdQlAT3uf07QahHKm5uaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Np5RaYzd; arc=none smtp.client-ip=45.254.49.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Np5RaYzd"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dcfbd58c;
	Fri, 19 Dec 2025 09:47:12 +0800 (GMT+08:00)
Content-Type: multipart/mixed; boundary="------------7vl8geDUPuZkBwkeCkTXs1jD"
Message-ID: <dbee3e27-d158-43d3-88ca-a9f3a3264af7@rock-chips.com>
Date: Fri, 19 Dec 2025 09:47:08 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>,
 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Marek Szyprowski <m.szyprowski@samsung.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
 <1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com>
 <CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>
 <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
X-HM-Tid: 0a9b344a214a09cckunm542c8e4b3e61e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5OTFYeTktLTk4ZSEMaQkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Np5RaYzdJ0ltismSMkS6eS7xEJoYTEjJFjgiyCCWUH7ISVkczSd2ovmGTk1/4fxewZJMGt8YWiZuX1CmGcC5m3KCQgyQEGFf18xeFuJMkgvJh5VIw2oDV+jGF0nRlb50BmrpTkcX8BsRLiL3ggQiLgSnHZeyvmNPUu7PIMbHBhQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=MmkKFjupOYoCXdkeu9+mScx2Z2Yb2n8SxcdfEkNRC+w=;
	h=date:mime-version:subject:message-id:from;

This is a multi-part message in MIME format.
--------------7vl8geDUPuZkBwkeCkTXs1jD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marek,

在 2025/12/19 星期五 2:23, Marek Szyprowski 写道:
> On 16.12.2025 12:50, Shawn Lin wrote:
>> This patch sets struct dw_mci as mmc_host's private data by
>> copying struct dw_mci passing to dw_mci_probe() in order to
>> achieve with mminimal changes. Then we remove slot everywhere.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
> strange, as it works fine on other, similar, Exynos5422 based Odroid
> boards. On Odroid-HC1 no MMC card is detected at all after this patch. I

Sorry for breaking Odroid-HC1 board. Indeed, it's strange other
Exynos5422-based bards work fine, as this patch wasn't supposed to be
board depend, even SoC depend. Looking closely again, still have no
idea what is happening on Odroid-HC1. I have no Odroid-HC1 board to
debug, could you kindly help applied the attached debug patch and
share the log?  Thanks.


> briefly checked the code and I don't see anything suspicious besides
> this host vs. local_host structure copying... Reverting $subject patch
> on top of linux-next fixes this issue.
> 
>> ---
>>
>> Changes in v3: None
>> Changes in v2:
>> - Fix dma_set_mask_and_coherent mistake by code rebase
>> - fix compile warning
>>
>>    drivers/mmc/host/dw_mmc-pltfm.c |   2 +-
>>    drivers/mmc/host/dw_mmc.c       | 250 ++++++++++++++++++----------------------
>>    drivers/mmc/host/dw_mmc.h       |  22 +---
>>    3 files changed, 120 insertions(+), 154 deletions(-)
>>
>> ...
> 
> Best regards

--------------7vl8geDUPuZkBwkeCkTXs1jD
Content-Type: text/plain; charset=UTF-8;
 name="0001-mmc-dw_mmc-debug-Odroid-HC1.patch"
Content-Disposition: attachment;
 filename="0001-mmc-dw_mmc-debug-Odroid-HC1.patch"
Content-Transfer-Encoding: base64

RnJvbSA5MmM4NWFjZWQ2MjJjYjU5ZGRhMmRkYmRhYzkwMDNjNWFkMTRiMzhjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBz
LmNvbT4KRGF0ZTogRnJpLCAxOSBEZWMgMjAyNSAwOTozOTowMiArMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIG1tYzogZHdfbW1jOiBkZWJ1ZyBPZHJvaWQtSEMxCgpTaWduZWQtb2ZmLWJ5OiBT
aGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9o
b3N0L2R3X21tYy5jIHwgMTUgKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21t
Yy9ob3N0L2R3X21tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9kd19tbWMuYwppbmRleCA4YTAz
NjIyLi5hYzU2ZDg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L2R3X21tYy5jCisr
KyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMKQEAgLTM4OCw3ICszODgsNyBAQCBzdGF0
aWMgdm9pZCBkd19tY2lfc3RhcnRfY29tbWFuZChzdHJ1Y3QgZHdfbWNpICpob3N0LAogCQkJ
CSBzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNtZCwgdTMyIGNtZF9mbGFncykKIHsKIAlob3N0LT5j
bWQgPSBjbWQ7Ci0JZGV2X3ZkYmcoaG9zdC0+ZGV2LAorCWRldl9pbmZvKGhvc3QtPmRldiwK
IAkJICJzdGFydCBjb21tYW5kOiBBUkdSPTB4JTA4eCBDTURSPTB4JTA4eFxuIiwKIAkJIGNt
ZC0+YXJnLCBjbWRfZmxhZ3MpOwogCkBAIC0xMzE5LDcgKzEzMTksNyBAQCBzdGF0aWMgdm9p
ZCBkd19tY2lfc3RhcnRfcmVxdWVzdChzdHJ1Y3QgZHdfbWNpICpob3N0KQogLyogbXVzdCBi
ZSBjYWxsZWQgd2l0aCBob3N0LT5sb2NrIGhlbGQgKi8KIHN0YXRpYyB2b2lkIGR3X21jaV9x
dWV1ZV9yZXF1ZXN0KHN0cnVjdCBkd19tY2kgKmhvc3QsIHN0cnVjdCBtbWNfcmVxdWVzdCAq
bXJxKQogewotCWRldl92ZGJnKCZob3N0LT5tbWMtPmNsYXNzX2RldiwgInF1ZXVlIHJlcXVl
c3Q6IHN0YXRlPSVkXG4iLAorCWRldl9pbmZvKCZob3N0LT5tbWMtPmNsYXNzX2RldiwgInF1
ZXVlIHJlcXVlc3Q6IHN0YXRlPSVkXG4iLAogCQkgaG9zdC0+c3RhdGUpOwogCiAJaG9zdC0+
bXJxID0gbXJxOwpAQCAtMTgwNSw2ICsxODA1LDcgQEAgc3RhdGljIHZvaWQgZHdfbWNpX3Jl
cXVlc3RfZW5kKHN0cnVjdCBkd19tY2kgKmhvc3QsIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJx
KQogCQlob3N0LT5zdGF0ZSA9IFNUQVRFX0lETEU7CiAKIAlzcGluX3VubG9jaygmaG9zdC0+
bG9jayk7CisJZGV2X2luZm8oaG9zdC0+ZGV2LCAiJXMgXG4iLCBfX2Z1bmNfXyk7CiAJbW1j
X3JlcXVlc3RfZG9uZShwcmV2X21tYywgbXJxKTsKIAlzcGluX2xvY2soJmhvc3QtPmxvY2sp
OwogfQpAQCAtMjY5OSw2ICsyNzAwLDcgQEAgc3RhdGljIGlycXJldHVybl90IGR3X21jaV9p
bnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQogCXBlbmRpbmcgPSBtY2lfcmVhZGwo
aG9zdCwgTUlOVFNUUyk7IC8qIHJlYWQtb25seSBtYXNrIHJlZyAqLwogCiAJaWYgKHBlbmRp
bmcpIHsKKwkJZGV2X2luZm8oaG9zdC0+ZGV2LCAicGVuZGluIGlycSAweCV4XG4iLCBwZW5k
aW5nKTsKIAkJLyogQ2hlY2sgdm9sdCBzd2l0Y2ggZmlyc3QsIHNpbmNlIGl0IGNhbiBsb29r
IGxpa2UgYW4gZXJyb3IgKi8KIAkJaWYgKChob3N0LT5zdGF0ZSA9PSBTVEFURV9TRU5ESU5H
X0NNRDExKSAmJgogCQkgICAgKHBlbmRpbmcgJiBTRE1NQ19JTlRfVk9MVF9TV0lUQ0gpKSB7
CkBAIC0yODk2LDggKzI4OTgsMTIgQEAgc3RhdGljIHN0cnVjdCBkd19tY2kgKmR3X21jaV9p
bml0X2hvc3Qoc3RydWN0IGR3X21jaSAqaG9zdCkKIAltZW1jcHkobG9jYWxfaG9zdCwgaG9z
dCwgc2l6ZW9mKCpob3N0KSk7CiAJbG9jYWxfaG9zdC0+bW1jID0gbW1jOwogCi0JaWYgKGhv
c3QtPnBkZXYpCisJaWYgKGhvc3QtPnBkZXYpIHsKKwkJZGV2X2luZm8oaG9zdC0+ZGV2LCAi
c2V0IGRydmRhdGEuICVwICVwXG4iLCBob3N0LT5wZGV2LCBsb2NhbF9ob3N0LT5wZGV2KTsK
IAkJcGxhdGZvcm1fc2V0X2RydmRhdGEoaG9zdC0+cGRldiwgbG9jYWxfaG9zdCk7CisJCXBs
YXRmb3JtX3NldF9kcnZkYXRhKGxvY2FsX2hvc3QtPnBkZXYsIGxvY2FsX2hvc3QpOworCQlk
ZXZfaW5mbyhob3N0LT5kZXYsICJzZXQgZHJ2ZGF0YSBlbmRcbiIpOworCX0KIAogCW1tYy0+
b3BzID0gJmR3X21jaV9vcHM7CiAKQEAgLTM0MjcsNyArMzQzMyw3IEBAIGludCBkd19tY2lf
cHJvYmUoc3RydWN0IGR3X21jaSAqaG9zdCkKIAogCWxvY2FsX2hvc3QgPSBkd19tY2lfaW5p
dF9ob3N0KGhvc3QpOwogCWlmIChJU19FUlIobG9jYWxfaG9zdCkpIHsKLQkJZGV2X2RiZyho
b3N0LT5kZXYsICJob3N0IGluaXQgZmFpbGVkXG4iKTsKKwkJZGV2X2Vycihob3N0LT5kZXYs
ICJob3N0IGluaXQgZmFpbGVkXG4iKTsKIAkJZ290byBlcnJfZG1hdW5tYXA7CiAJfQogCkBA
IC0zNDM2LDYgKzM0NDIsNyBAQCBpbnQgZHdfbWNpX3Byb2JlKHN0cnVjdCBkd19tY2kgKmhv
c3QpCiAJCQkgICAgICAgbG9jYWxfaG9zdC0+aXJxX2ZsYWdzLCAiZHctbWNpIiwgbG9jYWxf
aG9zdCk7CiAJaWYgKHJldCkKIAkJZ290byBlcnJfZG1hdW5tYXA7CisJZGV2X2luZm8oaG9z
dC0+ZGV2LCAicmVxdWVzdCBpcnEuLi5cbiIpOwogCiAJLyogTm93IHRoYXQgaG9zdCBpcyBh
bGwgc2V0dXAsIHdlIGNhbiBlbmFibGUgY2FyZCBkZXRlY3QgKi8KIAlkd19tY2lfZW5hYmxl
X2NkKGxvY2FsX2hvc3QpOwotLSAKMi43LjQKCg==

--------------7vl8geDUPuZkBwkeCkTXs1jD--
