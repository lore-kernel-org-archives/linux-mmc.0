Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024334;
	b=WD9Ef8bsE8LCoUj3NwE6e6Nqa99uyRSZTddsfutvCN/d0ZB+Zn1QdabjzjafJDibjRXR
	 z5XFQh2sfCNud3bAJtZiTa6/nBdYs5sR3WMjs4cuj5wL683yGQJqysCkgU7pbVXbyinHl
	 V/ijFRsRrhqsyY8t0s1hpCk58UuS2o5Hs8RuDse2FLXkVRaqzj413fNJgirnb85l266i3
	 IU4fuvdicWAyaQ4PFLZ/2Oewr/RQLU+FieFdmu+Ie5fx0JVzvFTN8v42pqDNxTbM8sign
	 h7EI4R7is2yx+dZoGAvFrkr7OowX1f65CxK6Z6srPD2kWT21yvIJGgDAdIDI1R2DuZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024334;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=4ARnCtd3uzto/PHgfCMWuGtlnwWSM7jlXaejDo5/H8E=;
	b=uKNdHBk+t0n70TOh+YDxn+ekGPPNQE/t1q4pbgW1qIR8VmElkYEMBAPpDSQKlfsjYOZ9
	 HUCkVyWIT8MRRL8BU9/2Y33NWDw5CkqPjnbG9hvL1SZfW5X0CN2rc+SqiDBBlFYVPzH0y
	 OVzdXWkPVhqX5eDdH6UcS2TOAgRH9o4QMuGgvDlr8ppuSyxtq2SDMEQWY2USGIxNyD5YN
	 hVVGyGyqrdTA0aUW3kAskkfjZAYdH5YtCrl4M6LUiWmc1dUBIrI5Wki4jwiOK9GziMgUe
	 iiTaFc0H5McYgrt4jGCaxU8awAhacBPFPAYqHDv8R+VyAvbe09xuT3l7VQL4YfzJlcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEjpn3Bc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDE8606A33D
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fEjpn3Bc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD131F0092C;
	Wed, 18 Nov 2026 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024333;
	bh=4ARnCtd3uzto/PHgfCMWuGtlnwWSM7jlXaejDo5/H8E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=fEjpn3BcPjPfxyKuZ7eWrBQcAsQ3tATqdn9wim6WNheqc8b/cDlhkKY+o0MYInRFB
	 OKRlXQjAsGwjFOu6XuQwaB7mLkzEJKVhDFlW88++/LuZNlItFDiaJgT7mJXI+AtIoT
	 M6MOQbgHW8vIqD9C8DbSWXw/OuFj+bXNb6cCd5rOIQ+ph1JT3UOqxf/8hylQDx8YfR
	 1tLLl5BgfitKjpju68/BxM1cqRM5I++IHiHxRPsYoDvzpznPQ92E5PM0vWAN07l/GA
	 42QwqPWsqgTW+th8CJPet1SVuI4rZrw3QDSOhE88niiV7pWZUmszHcjJzx9EhrvhmH
	 0vob3WQ90be0A==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 3BFAA198003A;
	Wed, 18 Nov 2026 12:52:11 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 18 Nov 2026 12:52:11 -0500
X-ME-Sender: <xms:yeX9ahl9MSfxN4sTMAroam9MjurPlx6ItgAx3JAsor09Qws2e9CVoA>
    <xme:yeX9anqNEQOjvo3J645XUlBVetwSNdA9UPWCxhTYrolv_d1XxJ4DsU_YFR5Jz-PzU
    pJ_MSXB7eY1QWNJyV17MUZTn34XSIZ0a6kWh6zU9TR_Qd8MSdIrfyQniA>
X-ME-Proxy-Cause: dmFkZTGXEjOHTyRbeH7wX+barNrdVzrhxIMtHH4AQ3khzLpzp+Mqso9wSQl02IsvrfAHa3
    W4JuqVmqapUTAs38f8bIAXgKPBDyb0SzYwWYtcCjXmbQL75fp9+bDNev+0g0FEPu+awqGa
    D9U1fUGfB4P5Z8vSjWvX/6fmjio69h5xdkehIWGWjfF1H8A5HSoyjEjXSupIynmerSa+e8
    /IlMY5VsIZpkoK34dANjv0z0PuMqTyDGitZ1qck+dG5ncATtKhSlF39rhg6OccX4e3/acr
    nVpu/MBrpwkbhJNznVcsPKQ1PwjHVQeIjbxUsGABeXqUVSs9CMYy463By1FRw2vF2MEArT
    JZBz3EmyKnUnQrtXRV37dpJ5a7H9r5/KAbvh8GQ0NP8nkU33uL/zh21pG+eazF/16NvmWx
    Qt/hG8bBkNL2a2/Q4JSmnT+FuGGGPBrYULKZpUUxQKPcMcGwcn7WBb7lqm/ig87vZcNX9o
    1sHHGp/R8/OVcbfBmliKsmgJnHolBW5V3+6zoJemjarNZqDBC9tWuqARhRu4A1Yf8AZcbk
    WUuJ2djoQEg0CeCYKnsTd2jn3MmgzAdPv4XTUegiGUcsGyG45lZGV91keIVX2/iBSgfy1O
    3/3CWWPUe5u3pViXFfa4slARg4NkXWDOzPAK0sLHKWiTJuzxEdrm7uzosRVQ
X-ME-Proxy: <xmx:y-X9akGk7YZ1oTFw1OVjVtjaMKU9M-vNJBtF6--GTt1zDiE339q8Pw>
    <xmx:y-X9aoR03U3DEoMg5ryracda4ucCATh8AuM1a9WAS4X4JysVCJc7VA>
    <xmx:y-X9atKqsQ0ggRr-yZdTkuXY0YrrdRe2FTfxzcRWgn0Gj0CLs5qpig>
    <xmx:y-X9arZrhAjC1KWsUzcP1vuh3fxe3d8zKkQiKA1W7NC6L26dAsEipA>
    <xmx:y-X9an88M6Q6nOx-kHuKARXrjVp3JPk6d32ltQPrk3EoetZy2EGayoFw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8B84032A0099; Wed, 18 Nov 2026 12:52:09 -0500 (EST)
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
X-ThreadId: AbyrFe5vH_go
Date: Wed, 18 Nov 2026 18:51:29 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Linus Walleij" <linusw@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Ulf Hansson" <ulfh@kernel.org>
Message-Id: <2236a38c-de88-4f83-8d46-2ea96c5ac915@app.fastmail.com>
In-Reply-To: <sashiko-outbox-221162@kernel.org>
References: <20261118134445.2909283-1-arnd@kernel.org>
 <sashiko-outbox-221162@kernel.org>
Subject: Re: [PATCH] mmc: sh_mmcif: rework sg_miter handling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026, at 15:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] mmc: sh_mmcif: DMA transfers leave data->bytes_xfered at 0
> - [High] mmc: sh_mmcif: blksz + 3 in sh_mmcif_read_block() and
>   sh_mmcif_write_block()
> - [Medium] mmc: sh_mmcif: PIO leaves data->bytes_xfered non-zero on
>   transfer error
> --
>
> commit 6f62463df398beb43ce5f1bf65cbfc2642c791de
> Author: Arnd Bergmann <arnd@arndb.de>
>
> mmc: sh_mmcif: rework sg_miter handling
>
> This commit converts the sh_mmcif PIO scatterlist iterator to use
> SG_MITER_LOCAL by mapping and stopping the iterator within each block
> transfer helper and tracking progress with data->bytes_xfered.
>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index 51be5dc82f6e6..4583c22e8989b 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -604,7 +604,7 @@ static void sh_mmcif_single_read(struct sh_mmcif_=
host *host,
>>  			   BLOCK_SIZE_MASK) + 3;
>> =20
>>  	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
>> -		       SG_MITER_TO_SG);
>> +		       SG_MITER_LOCAL | SG_MITER_TO_SG);
>> =20
>>  	host->wait_for =3D MMCIF_WAIT_FOR_READ;
>> =20
>> @@ -621,7 +621,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_h=
ost *host)
>>  	int i;
>> =20
>>  	if (host->sd_error) {
>> -		sg_miter_stop(sgm);
>>  		data->error =3D sh_mmcif_error_manage(host);
>>  		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
>>  		return false;
>> @@ -629,7 +628,6 @@ static bool sh_mmcif_read_block(struct sh_mmcif_h=
ost *host)
>> =20
>>  	if (!sg_miter_next(sgm)) {
>>  		/* This should not happen on single blocks */
>> -		sg_miter_stop(sgm);
>>  		return false;
>>  	}
>> =20
>> @@ -638,6 +636,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_h=
ost *host)
>>  	for (i =3D 0; i < host->blocksize / 4; i++)
>>  		*p++ =3D sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
>> =20
>> +	data->bytes_xfered +=3D host->blocksize;
>> +	sgm->consumed =3D host->blocksize;
>>  	sg_miter_stop(&host->sg_miter);
>
> [Severity: High]
> Does setting sgm->consumed and data->bytes_xfered to host->blocksize h=
ere
> (and in sh_mmcif_write_block()) trigger WARN_ON(miter->consumed >
> miter->length) in sg_miter_stop() and over-report data->bytes_xfered b=
y 3
> bytes?
>
> sh_mmcif_single_read() and sh_mmcif_single_write() initialize
> host->blocksize to (MMCIF_CE_BLOCK_SET & BLOCK_SIZE_MASK) + 3 to round=
 up
> the 32-bit word loop, so host->blocksize is data->blksz + 3 while
> sgm->length is only data->blksz.

I've changed this to no longer refer to host->blocksize now:

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7f1818831f93..cade6ae7d44f 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -636,8 +636,8 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host=
 *host)
 	for (i =3D 0; i < host->blocksize / 4; i++)
 		*p++ =3D sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
=20
-	data->bytes_xfered +=3D host->blocksize;
-	sgm->consumed =3D host->blocksize;
+	data->bytes_xfered +=3D 4*i;
+	sgm->consumed =3D 4*i;
 	sg_miter_stop(&host->sg_miter);
=20
 	/* buffer read end */
@@ -688,13 +688,13 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_h=
ost *host)
 	for (i =3D 0; i < host->blocksize / 4; i++)
 		*p++ =3D sh_mmcif_readl(host->addr, MMCIF_CE_DATA);
=20
-	data->bytes_xfered +=3D host->blocksize;
-	sgm->consumed =3D host->blocksize;
+	data->bytes_xfered +=3D 4*i;
+	sgm->consumed =3D 4*i;
 	sg_miter_stop(sgm);
=20
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
=20
-	return data->bytes_xfered < host->blocksize * data->blocks;
+	return data->bytes_xfered < data->blksz * data->blocks;
 }
=20
 static void sh_mmcif_single_write(struct sh_mmcif_host *host,
@@ -738,8 +738,8 @@ static bool sh_mmcif_write_block(struct sh_mmcif_hos=
t *host)
 	for (i =3D 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
=20
-	data->bytes_xfered +=3D host->blocksize;
-	sgm->consumed =3D host->blocksize;
+	data->bytes_xfered +=3D 4 * i;
+	sgm->consumed =3D 4 * i;
 	sg_miter_stop(&host->sg_miter);
=20
 	/* buffer write end */
@@ -790,13 +790,13 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_=
host *host)
 	for (i =3D 0; i < host->blocksize / 4; i++)
 		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
=20
-	data->bytes_xfered +=3D host->blocksize;
-	sgm->consumed =3D host->blocksize;
+	data->bytes_xfered +=3D 4 * i;
+	sgm->consumed =3D 4 * i;
 	sg_miter_stop(sgm);
=20
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
=20
-	return data->bytes_xfered < host->blocksize * data->blocks;
+	return data->bytes_xfered < data->blksz * data->blocks;
 }
=20
 static void sh_mmcif_get_response(struct sh_mmcif_host *host,


>> @@ -792,27 +777,26 @@ static bool sh_mmcif_mwrite_block(struct sh_mmc=
if_host *host)
>>  	int i;
>> =20
>>  	if (host->sd_error) {
>> -		sg_miter_stop(sgm);
>>  		data->error =3D sh_mmcif_error_manage(host);
>>  		dev_dbg(dev, "%s(): %d\n", __func__, data->error);
>>  		return false;
>>  	}
>> =20
>> +	if (!sg_miter_next(sgm))
>> +		return false;
>> +
>>  	p =3D sgm->addr;
>> =20
>>  	for (i =3D 0; i < host->blocksize / 4; i++)
>>  		sh_mmcif_writel(host->addr, MMCIF_CE_DATA, *p++);
>> =20
>> +	data->bytes_xfered +=3D host->blocksize;
>>  	sgm->consumed =3D host->blocksize;
>> -
>> -	if (!sg_miter_next(sgm)) {
>> -		sg_miter_stop(sgm);
>> -		return false;
>> -	}
>> +	sg_miter_stop(sgm);
>> =20
>>  	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
>> =20
>> -	return true;
>> +	return data->bytes_xfered < host->blocksize * data->blocks;
>>  }
>
> [Severity: Medium]>
> --=20
> Sashiko AI review =C2=B7=20
> https://sashiko.dev/#/patchset/20261118134445.2909283-1-arnd@kernel.or=
g?part=3D1
> What happens if a PIO transfer encounters an error or timeout after on=
e or
> more blocks have been transferred to or from MMCIF_CE_DATA?
>
> In the single-block and multi-block PIO helpers, data->bytes_xfered is
> incremented as soon as the controller FIFO is accessed, before
> MMCIF_WAIT_FOR_READ_END, MMCIF_WAIT_FOR_WRITE_END, or MMCIF_WAIT_FOR_S=
TOP
> completes.  If a later step or sh_mmcif_timeout_work() fails, data->er=
ror
> (or mrq->stop->error) is set while data->bytes_xfered remains non-zero,
> which causes mmc_blk_mq_rw_recovery() and mmc_blk_mq_complete_rq() to =
treat
> those unconfirmed bytes as successfully transferred with BLK_STS_OK.

Not sure what we actually want data->bytes_xfered to be in this case,
I would guess that if the FIFO access went through, we should count it,
but to be on the safe side I can reset the value in the error case
and leave the behavior unchanged here:

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index cade6ae7d44f..6c3aff6e8c46 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1253,6 +1253,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *de=
v_id)
 		break;
 	case MMCIF_WAIT_FOR_STOP:
 		if (host->sd_error) {
+			mrq->data->bytes_xferred =3D 0;
 			mrq->stop->error =3D sh_mmcif_error_manage(host);
 			dev_dbg(dev, "%s(): %d\n", __func__, mrq->stop->error);
 			break;
@@ -1263,6 +1264,7 @@ static irqreturn_t sh_mmcif_irqt(int irq, void *de=
v_id)
 	case MMCIF_WAIT_FOR_READ_END:
 	case MMCIF_WAIT_FOR_WRITE_END:
 		if (host->sd_error) {
+			mrq->data->bytes_xferred =3D 0;
 			mrq->data->error =3D sh_mmcif_error_manage(host);
 			dev_dbg(dev, "%s(): %d\n", __func__, mrq->data->error);
 		}
@@ -1378,6 +1380,7 @@ static void sh_mmcif_timeout_work(struct work_stru=
ct *work)
 	case MMCIF_WAIT_FOR_WRITE:
 	case MMCIF_WAIT_FOR_READ_END:
 	case MMCIF_WAIT_FOR_WRITE_END:
+		mrq->data->bytes_xferred =3D 0;
 		mrq->data->error =3D sh_mmcif_error_manage(host);
 		break;
 	default:

>> @@ -1296,9 +1280,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void =
*dev_id)
>> =20
>>  	if (host->wait_for !=3D MMCIF_WAIT_FOR_STOP) {
>>  		struct mmc_data *data =3D mrq->data;
>> -		if (!mrq->cmd->error && data && !data->error)
>> -			data->bytes_xfered =3D
>> -				data->blocks * data->blksz;
>> =20
>>  		if (mrq->stop && !mrq->cmd->error && (!data || !data->error)) {
>>  			sh_mmcif_stop_cmd(host, mrq);
>
> [Severity: High]
> Does removing this assignment leave data->bytes_xfered at 0 for all DMA
> transfers?
>
> When DMA is used, sh_mmcif_end_cmd() waits for host->dma_complete
> synchronously and never calls the PIO block helpers, and only touches
> data->bytes_xfered to zero it on error:
>
> drivers/mmc/host/sh_mmcif.c:sh_mmcif_end_cmd() {
>     ...
> 	if (data->error) {
> 		data->bytes_xfered =3D 0;
> 		/* Abort DMA */
> 		if (data->flags & MMC_DATA_READ)
> 			dmaengine_terminate_sync(host->chan_rx);
> 		else
> 			dmaengine_terminate_sync(host->chan_tx);
> 	}
>     ...
> }
>
> Every successful DMA read or write will therefore complete with
> data->bytes_xfered =3D=3D 0 and fail in the MMC block layer.

I see. I could either put back the original line, or move it
into sh_mmcif_end_cmd() for the DMA code path only:

@@ -1178,6 +1178,8 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host =
*host)
                        dmaengine_terminate_sync(host->chan_rx);
                else
                        dmaengine_terminate_sync(host->chan_tx);
+       } else {
+               data->bytes_xfered =3D data->blksz * data->blocks;
        }
=20
        /*

Let me know if you have a preference, otherwise I'll go with this one.

      Arnd
