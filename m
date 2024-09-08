Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082118C22
	for <linux-mmc@vger.kernel.org>; Sun,  8 Sep 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797091; cv=none; b=iazDC16POdqJ50IG0QJukKMYzwqyVxat2dLA0ucEVHB2+ODBC4Ff+qLIqm/Z+5gjDD7yKU9yFStIhgKNb1s4qBEAt2TtUGXPgZzK0r5W8bCbnzbQy1QiDpIbDhQ8jiT0gUzhyKhX2TODIwQXPCoVpkvb216WwHP0hnazpI4uO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797091; c=relaxed/simple;
	bh=hjbOxk7ILgWGOkrRhzgnNH2YjEQZrpZcm3IXOb6UD4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYnPMcurtQ6DOqiajrYztsiWpK7g56lWHdqkU6oXnOwVnGH/Lc77yMFYO2D6XLm9uqPgkaavIAPIwh71hGkuYxvTMJLLdouXtv5yTBZi1HrvqtX3iGWeW50xiHdfJCSdGVb3vmUJ1CUx9BaQ96KJjglOqiuAhy/2MlxWHc0g3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938BD113E;
	Sun,  8 Sep 2024 05:05:09 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D32B3F66E;
	Sun,  8 Sep 2024 05:04:40 -0700 (PDT)
Message-ID: <6cb63826-e6b4-4e3b-92e3-5a5c912eedea@arm.com>
Date: Sun, 8 Sep 2024 13:04:38 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] mmc: core: Prevent HSQ from enabling for SDUC
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ricky WU <ricky_wu@realtek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
References: <20240908102018.3711527-1-avri.altman@wdc.com>
 <20240908102018.3711527-10-avri.altman@wdc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240908102018.3711527-10-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/24 11:20, Avri Altman wrote:
> Prevent Host Software Queue from enabling for SDUC. In SDUC, CMD44 is
> modified to include 6-bit upper address by utilizing its reserved bits.
> Exclude hsq for SDUC for now.

The message here is misleading, actually hsq has nothing to do with the
actual CQ as in CMD44, it's just a hack to present itself to the mmc
subsystem as such to then get more in-flight requests from mmc core,
which can be prepared in advance and be issued asynchronously to
the completion of the preceding request (in atomic context). So the card
is completely oblivious to hsq.
This is presumably broken though by the mandatory CMD22 for SDUC.

> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1d09f0f2e769..5d35fc8802c7 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1558,7 +1558,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  			goto free_card;
>  	}
>  
> -	if (host->cqe_ops && !host->cqe_enabled) {
> +	if (!mmc_card_ult_capacity(card) && host->cqe_ops && !host->cqe_enabled) {
>  		err = host->cqe_ops->cqe_enable(host, card);
>  		if (!err) {
>  			host->cqe_enabled = true;

