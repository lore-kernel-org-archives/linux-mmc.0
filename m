Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A96C2B9F4
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 13:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24EB361883
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 13:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhF1NnE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Jun 2021 09:43:04 -0400
Received: from foss.arm.com ([217.140.110.172]:59592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhF1NnE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Jun 2021 09:43:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982E01042;
        Mon, 28 Jun 2021 06:40:38 -0700 (PDT)
Received: from [10.57.8.89] (unknown [10.57.8.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 649B63F718;
        Mon, 28 Jun 2021 06:40:36 -0700 (PDT)
Subject: Re: [PATCH RFC 1/2] scatterlist: add I/O variant of sg_pcopy &
 sg_copy
To:     Neil Armstrong <narmstrong@baylibre.com>, jgg@ziepe.ca,
        leon@kernel.org, m.szyprowski@samsung.com, ulf.hansson@linaro.org
Cc:     torvalds@linux-foundation.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210628123411.119778-1-narmstrong@baylibre.com>
 <20210628123411.119778-2-narmstrong@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d86f72ff-191a-fbf1-b1d1-7c980b488bcd@arm.com>
Date:   Mon, 28 Jun 2021 14:40:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628123411.119778-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-06-28 13:34, Neil Armstrong wrote:
> When copying from/to an iomem mapped memory, the current sg_copy & sg_pcopy can't
> be used and lead to local variants in drivers like in [1] & [2].
> 
> This introduces an I/O variant to be used instead of the local variants.
> 
> [1] mv_cesa_sg_copy in drivers/crypto/marvell/cesa/tdma.c
> [2] meson_mmc_copy_buffer in drivers/mmc/host/meson-gx-mmc.c

Other than one apparent typo below, this looks like what I imagined, 
thanks for putting it together!

> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   include/linux/scatterlist.h |  14 +++++
>   lib/scatterlist.c           | 119 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 133 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6f70572b2938..6ef339ba5290 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -308,15 +308,29 @@ void sgl_free(struct scatterlist *sgl);
>   size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
>   		      size_t buflen, off_t skip, bool to_buffer);
>   
> +size_t sg_copy_io(struct scatterlist *sgl, unsigned int nents, void __iomem *buf,
> +		  size_t buflen, off_t skip, bool to_buffer);
> +
>   size_t sg_copy_from_buffer(struct scatterlist *sgl, unsigned int nents,
>   			   const void *buf, size_t buflen);
>   size_t sg_copy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>   			 void *buf, size_t buflen);
>   
> +size_t sg_copy_from_io(struct scatterlist *sgl, unsigned int nents,
> +		       const void __iomem *buf, size_t buflen);
> +size_t sg_copy_to_io(struct scatterlist *sgl, unsigned int nents,
> +		     void __iomem *buf, size_t buflen);
> +
>   size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
>   			    const void *buf, size_t buflen, off_t skip);
>   size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>   			  void *buf, size_t buflen, off_t skip);
> +
> +size_t sg_pcopy_from_io(struct scatterlist *sgl, unsigned int nents,
> +			const void __iomem *buf, size_t buflen, off_t skip);
> +size_t sg_pcopy_to_io(struct scatterlist *sgl, unsigned int nents,
> +		      void __iomem *buf, size_t buflen, off_t skip);
> +
>   size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
>   		       size_t buflen, off_t skip);
>   
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index a59778946404..e52f37b181fa 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -954,6 +954,55 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
>   }
>   EXPORT_SYMBOL(sg_copy_buffer);
>   
> +/**
> + * sg_copy_io - Copy data between an I/O mapped buffer and an SG list
> + * @sgl:		 The SG list
> + * @nents:		 Number of SG entries
> + * @buf:		 Where to copy from
> + * @buflen:		 The number of bytes to copy
> + * @skip:		 Number of bytes to skip before copying
> + * @to_buffer:		 transfer direction (true == from an sg list to a
> + *			 buffer, false == from a buffer to an sg list)
> + *
> + * Returns the number of copied bytes.
> + *
> + **/
> +size_t sg_copy_io(struct scatterlist *sgl, unsigned int nents, void __iomem *buf,
> +		  size_t buflen, off_t skip, bool to_buffer)
> +{
> +	unsigned int offset = 0;
> +	struct sg_mapping_iter miter;
> +	unsigned int sg_flags = SG_MITER_ATOMIC;
> +
> +	if (to_buffer)
> +		sg_flags |= SG_MITER_FROM_SG;
> +	else
> +		sg_flags |= SG_MITER_TO_SG;
> +
> +	sg_miter_start(&miter, sgl, nents, sg_flags);
> +
> +	if (!sg_miter_skip(&miter, skip))
> +		return 0;
> +
> +	while ((offset < buflen) && sg_miter_next(&miter)) {
> +		unsigned int len;
> +
> +		len = min(miter.length, buflen - offset);
> +
> +		if (to_buffer)
> +			memcpy_toio(buf + offset, miter.addr, len);
> +		else
> +			memcpy_fromio(miter.addr, buf + offset, len);
> +
> +		offset += len;
> +	}
> +
> +	sg_miter_stop(&miter);
> +
> +	return offset;
> +}
> +EXPORT_SYMBOL(sg_copy_io);
> +
>   /**
>    * sg_copy_from_buffer - Copy from a linear buffer to an SG list
>    * @sgl:		 The SG list
> @@ -988,6 +1037,40 @@ size_t sg_copy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>   }
>   EXPORT_SYMBOL(sg_copy_to_buffer);
>   
> +/**
> + * sg_copy_from_io - Copy from an I/O mapped buffer to an SG list
> + * @sgl:		 The SG list
> + * @nents:		 Number of SG entries
> + * @buf:		 Where to copy from
> + * @buflen:		 The number of bytes to copy
> + *
> + * Returns the number of copied bytes.
> + *
> + **/
> +size_t sg_copy_from_io(struct scatterlist *sgl, unsigned int nents,
> +		       const void *buf, size_t buflen)

The __iomem annotation wants to be on buf here raher than cast in below, 
to match the prototype (and everything else).

Cheers,
Robin.

> +{
> +	return sg_copy_io(sgl, nents, (void __iomem *)buf, buflen, 0, false);
> +}
> +EXPORT_SYMBOL(sg_copy_from_io);
> +
> +/**
> + * sg_copy_to_io - Copy from an SG list to an I/O mapped buffer
> + * @sgl:		 The SG list
> + * @nents:		 Number of SG entries
> + * @buf:		 Where to copy to
> + * @buflen:		 The number of bytes to copy
> + *
> + * Returns the number of copied bytes.
> + *
> + **/
> +size_t sg_copy_to_io(struct scatterlist *sgl, unsigned int nents,
> +		     void __iomem *buf, size_t buflen)
> +{
> +	return sg_copy_io(sgl, nents, buf, buflen, 0, true);
> +}
> +EXPORT_SYMBOL(sg_copy_to_io);
> +
>   /**
>    * sg_pcopy_from_buffer - Copy from a linear buffer to an SG list
>    * @sgl:		 The SG list
> @@ -1024,6 +1107,42 @@ size_t sg_pcopy_to_buffer(struct scatterlist *sgl, unsigned int nents,
>   }
>   EXPORT_SYMBOL(sg_pcopy_to_buffer);
>   
> +/**
> + * sg_pcopy_from_io - Copy from an I/O mapped buffer to an SG list
> + * @sgl:		 The SG list
> + * @nents:		 Number of SG entries
> + * @buf:		 Where to copy from
> + * @buflen:		 The number of bytes to copy
> + * @skip:		 Number of bytes to skip before copying
> + *
> + * Returns the number of copied bytes.
> + *
> + **/
> +size_t sg_pcopy_from_io(struct scatterlist *sgl, unsigned int nents,
> +			const void __iomem *buf, size_t buflen, off_t skip)
> +{
> +	return sg_copy_io(sgl, nents, (void __iomem *)buf, buflen, skip, false);
> +}
> +EXPORT_SYMBOL(sg_pcopy_from_io);
> +
> +/**
> + * sg_pcopy_to_io - Copy from an SG list to an I/O mapped buffer
> + * @sgl:		 The SG list
> + * @nents:		 Number of SG entries
> + * @buf:		 Where to copy to
> + * @buflen:		 The number of bytes to copy
> + * @skip:		 Number of bytes to skip before copying
> + *
> + * Returns the number of copied bytes.
> + *
> + **/
> +size_t sg_pcopy_to_io(struct scatterlist *sgl, unsigned int nents,
> +		      void __iomem *buf, size_t buflen, off_t skip)
> +{
> +	return sg_copy_io(sgl, nents, buf, buflen, skip, true);
> +}
> +EXPORT_SYMBOL(sg_pcopy_to_io);
> +
>   /**
>    * sg_zero_buffer - Zero-out a part of a SG list
>    * @sgl:		 The SG list
> 
