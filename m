Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893221B9D2
	for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771203; cv=none; b=JlI70LV51YVM2uIRJVvxMIzp0yVmXzTAxH9l5ylE6IBz/BM0ByQHCY+aRWl2vS9KBCKIouLh54fnZ9qXz37PteY8KghQUaEJH1Z0Yi2tbBkNy3+JM5tVTjBQAKq9fBul+RsRbzd+EfFcZhKuRlsIeEUBemm/kIfYtmOS9ymflZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771203; c=relaxed/simple;
	bh=a/zVTBTJCkhqwYXrRY+kvqL7QQoB6agEJ522P8fp8X8=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=B4KEJdG7ytYf37mBoVQNRiFsgl/rvNJgAJnDc8OZSPbZyWGH4LzangLFmwxYXN4w3aXVTLju1HxDXeN3JxIoG4JCQ+BqiSRkfoY1yhCkb2RuaQYf1bTrw6T30QZFzFrPJ1uDYU7xYyQOOdHeSkO8ZC3kjU03hcGWlJaRBZkoiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=id9qbyNY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="id9qbyNY"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769771197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3vxerl3l/rTYyFUDIDIlNUdhJIJrffcuAG4CqptJc/s=;
	b=id9qbyNYPtxzV6e9loV9fl2jQrot2PnXfSu+GHErqSJ+3B36R8yAmsR1p+ryQyvYQ/YBl/
	ztnWl8OZv0atKv6CcyQ4leEVoa6F0b1Yf2fGbUATE8pelalgxskyM5h0dSc5cyniaheqMt
	bYvK4vXJHYP5sFNQbp10+FWvPMbd7fQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
Message-Id: <56AD8238-302F-4FDC-8ECD-842B0B92F1BE@linux.dev>
Date: Fri, 30 Jan 2026 03:06:21 -0800
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
X-Migadu-Flow: FLOW_OUT

=EF=BB=BF

> On Jan 30, 2026, at 2:53=E2=80=AFAM, Adrian Hunter <adrian.hunter@intel.co=
m> wrote:
>=20
> =EF=BB=BFGenesys folks : Any comment on this?

As an update on my end, I=E2=80=99ve heard positive feedback from several us=
ers testing this out saying it=E2=80=99s the first time they have not had is=
sues writing data to an SD card with GL9750. They were able to install games=
 that would previously fail with file integrity errors and then game off the=
 SD card.

I was planning on sending this out as a v1 before I leave on vacation next w=
eek unless there were any further comments here.

>=20
>> On 18/01/2026 01:48, Matthew Schwartz wrote:
>> The GL9750 SD host controller has intermittent data corruption during
>> DMA write operations, which has been traced to an incorrect burst
>> configuration. This was discovered by comparing initialization sequences
>> between the working GL9767 controller and GL9750 and seeing that the
>> GM_BURST register was handled differently.
>> Clearing bits 16-17 eliminates the corruption with f3write/f3read tests
>> while maintaining full DMA write/read performance.
>> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x supp=
ort")
>> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa118=
31fad@linux.dev/
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>> Hi all,
>> I arrived at this after a whole bunch of guesswork based on the other
>> Genesys card readers in the kernel that do work, like GL9767. I landed on=

>> register 0x510 which appears to be "GM_BURST_SIZE" and ended up going
>> through each bit and either setting it or masking it. Eventually, I
>> arrived at masking bits 16-17 which seemed to stabilize writes completely=
.
>> Could someone at Genesys confirm what this register is for on GL9750, and=

>> what those bits are? At least locally, I have been able to run 50GB of
>> f3write/f3read without any corruption while before even 1GB would corrupt=
.
>> This also maintains the same read/write speed as before this change. I
>> tried searching online but was unable to find any relevant docs, and I'd
>> like to confirm the purpose of those bits before sending this out as v1.
>> Thanks,
>> Matt
>> ---
>> drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
>> index b0f91cc9e40e4..a06b0cf11f12d 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -26,6 +26,9 @@
>> #define   GLI_9750_WT_EN_ON        0x1
>> #define   GLI_9750_WT_EN_OFF        0x0
>> +#define SDHCI_GLI_9750_GM_BURST_SIZE          0x510
>> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_MASK        GENMASK(17, 16)
>> +
>> #define SDHCI_GLI_9750_CFG2          0x848
>> #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>> #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
>> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *hos=
t)
>>   gl9750_wt_on(host);
>> +    /* clear GM_BURST bits to avoid corruption with DMA writes */
>> +    value =3D sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
>> +    value &=3D ~SDHCI_GLI_9750_GM_BURST_SIZE_MASK;
>> +    sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
>> +
>>   value =3D sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>>   value &=3D ~SDHCI_GLI_9750_CFG2_L1DLY;
>>   /* set ASPM L1 entry delay to 7.9us */
