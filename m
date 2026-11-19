Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101719;
	b=HpYAET7ApKQk3MayNYRkbL8ICs0gcdvk9IlE3xOfCw2ttSTI/+CI+LLBGm99BYvPznGl
	 7XL1ma6qN9cADAu3TOFKmuIMbIzGHMk0hWV+yxTOXb7La1/hf+dMbupm2c4nZVCWQGGLQ
	 SHt0kSrRKx9vypR9CmWRnuif7HA/RePQDEdwsJDSm843xllnNiJJSmISbcJr6ubttI7LW
	 8Z/XcE8utVm6beI05DXO9zjYHiHaz7m+RfJAl9x9+C9dojNHMH298ZOx4VLkq29wY5tC/
	 FC9A9AZgimI9+IEfpmESqu0bBxWkUpBYHlMxnp+uTGsA7FI9aPtZ1MqHFbT9wI84ToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101719;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=5l8GqR1pMHHk4vhkBIQpJlp6jJQ7JDN3kxOn/4iGrAc=;
	b=YwtjKF3jslUoEBmo0CgCRYhzyk2I1FRzqvy9XbKnEUSsU+GQx6Y2rwROfM+4sSUAR4iL
	 AXbhC+w5Zdi85hP19fEPNlFcnzg43qTyv4m1GylFQ53qnv5mxvvCVO/1oJyH02mmTffTl
	 fZ4iBzT6k12O+jk3odTVxUl5S+0F/035nBB1gVZ+wFjKyakwI+oVvsvcQ/N5kDgqDdC2Q
	 +DBriFSIFjmvnH1bk2vA9ZX9gsl5vxBMLwzADTLDRLRuJq191OQyt00mRs85Z9I4VNwEc
	 CfwyHlu1q+8WDqd/Srlzyu7jp6q8R53LE0cruwiGTM4BOA2f254ReANO6e6jATFerag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSetPPx1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F2606A324;
	Thu, 19 Nov 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSetPPx1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0352E1F000C8;
	Thu, 19 Nov 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101718;
	bh=5l8GqR1pMHHk4vhkBIQpJlp6jJQ7JDN3kxOn/4iGrAc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=OSetPPx1twH283yAOInw1fVxzhw6z+BPC5Tlx5mIjAXPmRFxG4D4S2lFePMSUqLm8
	 Gndj7p8fZcCVNUVRaWM3hlQhJJxuunUnD/wZCQ5C+kK8YJ3HOHZGl9WyT3nTY9Wpfb
	 PQLGNJ9JEuzopCag+K0UdCoO06QGot6gcOXeEzO2Ih+t6g/Lm/+xzZ8DC/pszbG3ae
	 naI4fex3IFeyWN7z9OW0uNUgQUnPHUnPzNiWCFvMTuMLMtT8z+iHMCqSN/p5khPqGV
	 rKvqO5cREgOR1LojY4hIewYADGa1nUY3RNOGz05xMqDJr45GbNzbiLh7MLtXZWFq+j
	 FHFxJ9U3clMmg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3C64D1980070;
	Thu, 19 Nov 2026 10:21:56 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 19 Nov 2026 10:21:56 -0500
X-ME-Sender: <xms:EhT_apq3zDL60VDfd6TM6kuSn8gYoR-zNDdjp2ps-AepjsU8pEu6kg>
    <xme:EhT_amdcpTc6LxFyP8eKCWJD411DbcuJxGQ0gKXaGq5H7RRCrYIdVBPGTKqC0p9f6
    CrM2Kr6SXwTWCpSRyIDa5afdU7jyH3VMTYwOcn9KHIjS6ptXULVAQgw>
X-ME-Proxy-Cause: dmFkZTFAW/rrkNPBzeKLhGsKQLHRswz64G63poKWKLw463QHaf+1d6xN/yc1sejtO6QZx5
    fWiT25IhBCJ8GMWFTQTjv17SWOHq++Oevi4ctTjpcivsO2LF2xQ2wswTLOK8ph6KV4LEED
    CQvmx85m+a3iOx/33ttWiG+PidCD8TTSn5aN6y1tEO0guG2ekBixUT53Q+TYyzKirYxiXP
    ooQJGLYtDJvYjEGVlV6SoXrpayOMHJayUEiFc6Xx/MkhbYKJMgSXrmDgkvf7SuAGeOkPd/
    AYTE8c+pNDG+vxK60r+h9Euncql3Rw4oB6YT/CjHquFMIQUYfAJALpcZy4OguG+Uz+3BbT
    3XA7FpyBGa8qGgavfhjZCnvR32BMweU7Bvwi3ScjH0hTzDi8p21OAdSV/kZ0zYxokVmZbR
    /GMjLXUJeKBSyzcNAhOfSCIIniCAK2couGCe1pWQnGF17mpgU5myXUlAqmFH4SUbbAiXk+
    HCxPMPwFOVE3O3YEQQYsHdXlILJe2rE/F+fW/seFx5bs49ySGwOUyKPJtGomHHxW0TzTco
    jWSs1ajdwaywdT9f8chb6Vk/NOkr/fPQPvf8ZJ/DQBH+VeGPa+2NZ5nbZCU94lePBQHSHX
    Qy9YKhx+WJUCWg7HysG8TiORDpE389ucvtaT5lED9LHM0kGto8+pSzmCCUnw
X-ME-Proxy: <xmx:FBT_asq5ALVgmDljti4u2jJqbZQ9SpUG35T6Du2mawnuQ4JrGSQxAw>
    <xmx:FBT_atm1orlVR3_XkVd0_SR8mJ-SYO3Cij9LvN5Wrig8t4iCq7lTDg>
    <xmx:FBT_agPavBnsWSlRJDN06fXXagaMJ7tLE_ARYd7BKFHIv-ihw-HdZg>
    <xmx:FBT_apOJ2TRSsPoXzryr-AeJs_NZe7Afdx7d24RCNS7OTHljfNK6ow>
    <xmx:FBT_apiBASsX6cjMETqXeG4ukwaVEVEJI-JyjCtrHzHjQupCxlOovebI>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B63EF32A0099; Thu, 19 Nov 2026 10:21:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AXSqIyz7GwKB
Date: Thu, 19 Nov 2026 16:21:34 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Linus Walleij" <linusw@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Ulf Hansson" <ulfh@kernel.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>
Message-Id: <169128b7-9b30-4e3a-a4b8-be46012b691c@app.fastmail.com>
In-Reply-To: <sashiko-outbox-222892@kernel.org>
References: <20261119093924.3508355-1-arnd@kernel.org>
 <sashiko-outbox-222892@kernel.org>
Subject: Re: [PATCH] [v2] mmc: sh_mmcif: rework sg_miter handling
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 19, 2026, at 10:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] mmc: sh_mmcif: data->bytes_xfered not reset on multi-block
>   PIO and stop errors
> - [Medium] mmc: sh_mmcif: out-of-bounds sgm->consumed in
>   sh_mmcif_read_block()
> --
>
> commit 65703f98092b0e4db22d64298984b4fb57add099
> Author: Arnd Bergmann <arnd@arndb.de>
>
> mmc: sh_mmcif: rework sg_miter handling
>
> This commit reworks PIO scatterlist mapping in sh_mmcif to use
> SG_MITER_LOCAL, stopping the iterator after each block and tracking
> completion via data->bytes_xfered.
>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index 51be5dc82f6e6..8a0ccab9861d5 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -604,7 +604,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_host *host,
>>  			   BLOCK_SIZE_MASK) + 3;
>>  
>>  	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
>> -		       SG_MITER_TO_SG);
>> +		       SG_MITER_LOCAL | SG_MITER_TO_SG);
>>  
>>  	host->wait_for = MMCIF_WAIT_FOR_READ;
>>  
>> @@ -621,7 +621,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
>>  	int i;
>>  
>>  	if (host->sd_error) {
>> -		sg_miter_stop(sgm);
>>  		data->error = sh_mmcif_error_manage(host);
>>  		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
>>  		return false;
>> @@ -629,7 +628,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
>>  
>>  	if (!sg_miter_next(sgm)) {
>>  		/* This should not happen on single blocks */
>> -		sg_miter_stop(sgm);
>>  		return false;
>>  	}
>>  
>> @@ -638,6 +636,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
>>  	for (i = 0; i < host->blocksize / 4; i++)
>>  		*p++ = sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
>>  
>> +	data->bytes_xfered += 4 * i;
>> +	sgm->consumed = 4 * i;
>>  	sg_miter_stop(&host->sg_miter);
>
> [Severity: Medium]
> Can setting sgm->consumed and data->bytes_xfered to 4 * i exceed
> sgm->length on single-block transfers whose data->blksz is not a multiple
> of 4?

I've gone back to reporting data->blksz for the single transfers now,
which I think is what we expect to transfer here. It is a bit odd that
nothing actually compares host->blocksize and data->blksz, maybe
there should be a check here as the loop could otherwise go long
or short and both of those would presumably be bad.

> sh_mmcif_single_read() and sh_mmcif_single_write() add 3 to
> host->blocksize so that host->blocksize / 4 rounds up the 32-bit FIFO word
> count.  When data->blksz is not divisible by 4, 4 * i is larger than
> data->blksz (and sgm->length), which triggers
> WARN_ON(miter->consumed > miter->length) in sg_miter_stop() and
> over-reports data->bytes_xfered in both sh_mmcif_read_block() and
> sh_mmcif_write_block().

Exactly, except that host->blocksize is not even set to data->blksz
in the first place.

>> @@ -1397,6 +1382,7 @@ static void sh_mmcif_timeout_work(struct work_struct *work)
>>  	case MMCIF_WAIT_FOR_WRITE:
>>  	case MMCIF_WAIT_FOR_READ_END:
>>  	case MMCIF_WAIT_FOR_WRITE_END:
>> +		mrq->data->bytes_xfered = 0;
>>  		mrq->data->error = sh_mmcif_error_manage(host);
>>  		break;
>>  	default:
>
> [Severity: Medium]
> Does this leave mrq->data->bytes_xfered non-zero when a multi-block PIO
> transfer hits host->sd_error or when MMCIF_WAIT_FOR_STOP times out?
>
> sh_mmcif_mread_block() and sh_mmcif_mwrite_block() increment
> data->bytes_xfered as each block is read from or written into the
> MMCIF_CE_DATA FIFO, but their host->sd_error paths do not reset
> data->bytes_xfered to 0 if an error interrupt arrives on a later block.
> Likewise, case MMCIF_WAIT_FOR_STOP in sh_mmcif_timeout_work() does not
> reset mrq->data->bytes_xfered to 0, unlike MMCIF_WAIT_FOR_STOP in
> sh_mmcif_irqt().
>
> When data->bytes_xfered remains non-zero on error, mmc_blk_mq_rw_recovery()
> and mmc_blk_mq_complete_rq() can treat those unverified or aborted blocks
> as completed with BLK_STS_OK.

This was intentional on my end: if something has already been transferred
through registers, I would count it. Since I already changed the other
instances, I have changed this one as well now, and just unconditionally
reset 'mrq->data->bytes_xfered = 0' in the timeout handler. No idea if
this is actually better or worse.

     Arnd
