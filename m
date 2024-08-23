Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523213B7BC;
	Fri, 23 Aug 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397787; cv=none; b=bkbGYQGrZXEuAN5e/7cLKbF9ykbTvd+BqNSZUP89f627DeZDNShs/8uYm5t44is/GCVBv3au01L2ERsxupBErYI9rg7U15xg538riaLnkBmk/88kNsuSuXkngxtA2/g45ECPaFRCQ8KxxxMqhKCgNLT4/JbKZgFaSA/s1x0v9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397787; c=relaxed/simple;
	bh=pkwZjd7axreB1196Pr5R2CaAwu0JxHMSBUSEgf+Tynk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VWZaNUpaBjv+9IV/IFBAd2metWSDG+l3fPZvmwMN1IpZLBzfTEswZLrK9FT1kP8RTwFyRgg95se+p/ObAnHfZ4zyMs1mMIlxO71aRWztNGvHr0kUwx/3XoSbBR34X6PIQkuiTynMGsEM0k288zrdkS9bHIKoNq0j0Z5HgoDtqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MLmIoJxn; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MLmIoJxn"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724397784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zbIKrcGYGStpZ6ut/qfVF6ZFmX3hFK6vNTCYPxcvsI=;
	b=MLmIoJxnTpJCob5x8ecf4IBHK7aK1cZ2kR1lTQIzQPw5ww4A4ebaq4rdbpJhEErVCgcOaE
	UXam0SfkxT20JwFifr3E8zGvhAQng910WkmIuz3+z/ekGHAmgBtV+QYrItMR5mHd7a93uZ
	k6zpiYR0zwjgEKQYPf2ABgJNr6HudzvdAFgGz7slD8eNlq1Zy9dlPfLfsBWVSeX4MDO30V
	k5l3DPfJE2i11UVpxCqEN5OApFmcsqj5Nmbh6M2b3JPtZGIJ4vzbg4V3rtf4YJ65La5VXw
	aC1AZnp8Q/Vg7+LZsFf9WsjY2MyLAT7S1VCRtW7KwsbdUzczrkoGtv7Bqn5zKQ==
Date: Fri, 23 Aug 2024 09:23:04 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, ritesh.list@gmail.com, grant.jung@samsung.com,
 jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com,
 jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com,
 wkon.kim@samsung.com
Subject: Re: [PATCH] mmc : fix for check cqe halt.
In-Reply-To: <7f81eb0943674983f771bbb292e0566f@manjaro.org>
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
 <20240823071025.15410-1-sh8267.baek@samsung.com>
 <7f81eb0943674983f771bbb292e0566f@manjaro.org>
Message-ID: <6bf83bab55ee44394e69696b5ac6be6e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-23 09:22, Dragan Simic wrote:
> Hello Seunghwan,
> 
> On 2024-08-23 09:10, Seunghwan Baek wrote:
>> To check if mmc cqe is in halt state, need to check
>> set/clear of CQHCI_HALT bit. At this time, we need to
>> check with &, not &&. Therefore, code to check whether
>> cqe is in halt state is modified to cqhci_halted,
>> which has already been implemented.
>> 
>> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
> 
> Looking good to me, thanks for the patch.  I'd suggest that you
> resend the patch with a proper "Fixes" tag, together with the
> "Cc: stable@vger.kernel.org" tag.
> 
> Maybe also reflow the patch description a bit, to use the 78-column
> width or so fully.

Oh, and please feel free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

>> ---
>>  drivers/mmc/host/cqhci-core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/cqhci-core.c 
>> b/drivers/mmc/host/cqhci-core.c
>> index c14d7251d0bb..3d5bcb92c78e 100644
>> --- a/drivers/mmc/host/cqhci-core.c
>> +++ b/drivers/mmc/host/cqhci-core.c
>> @@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host 
>> *cq_host)
>> 
>>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>> 
>> -	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
>> +	if (cqhci_halted(cq_host))
>>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>> 
>>  	mmc->cqe_on = true;
>> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc,
>> struct mmc_request *mrq)
>>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>>  		mmc->cqe_on = true;
>>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
>> -		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
>> +		if (cqhci_halted(cq_host)) {
>>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>>  			       mmc_hostname(mmc));
>>  		}
