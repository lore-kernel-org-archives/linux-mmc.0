Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686DF58AA5;
	Mon,  3 Jun 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.159.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405817; cv=none; b=qoibs/JNk9pu6sDSBqrbmVIeocDL5WbkGOqIMre6ZdyHNBX7QHwGK9sNcuMrwCnbH64dGILiwc+NcLBTPfvaj4Y1bBYWNmbH2+Gb5q84+IL5x79z559CuYE12GSMACTlypMYj7KVAdZWDrUGVYNO46NMk7V9QwvSnCgM4JXOVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405817; c=relaxed/simple;
	bh=oS5YZddoPc4pdpbHd3+FPlRMuiMilpWAdNoYT9363KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8Kop4M+fP1OtDp8LWnmZcHt6IePm6f+UwSiqSsCgb590mAvkWDE6bENTBkpuAOV4irhUHDThUZWiG7N/L0Cgth98jdlhPld2ujCxeu24y6dQ5X/KGyaRCV80ROPh3qMTsAWfQNFcGeAST6S2MmUilAJEQ/D/dgJ5TLomSMyZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net; spf=none smtp.mailfrom=manut.de; dkim=fail (0-bit key) header.d=mecka.net header.i=@mecka.net header.b=rekliKSH reason="key not found in DNS"; arc=none smtp.client-ip=159.69.159.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manut.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="rekliKSH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1717405805; bh=oS5YZddoPc4pdpbHd3+FPlRMuiMilpWAdNoYT9363KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rekliKSHCind4MUrk/8G3AJXqOlSTrnFhXiuGX+m/TIb4xl0QB5r8M0485lu/JRgJ
	 2+rS0xnduZ2+v61t76tL4Fx2Bd6CiBENRrnfUf7KgAdUZVmP7dRZ8ay8XcXhEukglT
	 6r/n3gwigb7u8DXX2YTT3VMfBLbWv8FcNX0tsKt1IfpF7XCaQZa9LQ0QvE7kd3EHHO
	 WtpWHUkGmmShUxuHqq1Pjzqs0Ry2q2RJIRpvv9nvY5ce95LOKhi87fQ/pbI9RcAkVL
	 MMAzWh1dxEYSmKvhjTz8MyWiNC+Jbxfq38FZxblWsWqhYThWvC8KldhiMwnt5A8bCG
	 Fjrn2atMya2gg==
Received: by mecka.net (Postfix, from userid 1000)
	id A46F950F212; Mon,  3 Jun 2024 11:10:05 +0200 (CEST)
Date: Mon, 3 Jun 2024 11:10:05 +0200
From: Manuel Traut <manut@mecka.net>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
Message-ID: <Zl2Ibey9Qck-VLWE@manut.de>
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527121340.3931987-5-jens.wiklander@linaro.org>

On 14:13 Mon 27 May     , Jens Wiklander wrote:
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/arm_ffa.h>
>  #include <linux/errno.h>
> +#include <linux/rpmb.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	optee->ffa.bottom_half_value = U32_MAX;
>  	optee->rpc_param_count = rpc_param_count;
>  
> +	if (IS_REACHABLE(CONFIG_RPMB) &&
> +	    (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> +		optee->in_kernel_rpmb_routing = true;

The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment.
If I remove this check here, the series works for me.

Cheers
Manuel
