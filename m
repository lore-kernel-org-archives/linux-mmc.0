Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF0C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 14:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiFHO3W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiFHO3R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 10:29:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7B3608A8;
        Wed,  8 Jun 2022 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654698543; x=1686234543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cVVGP+l6ylx7H1FVQbM9NOgNouxbd4z5Jik1bOizeC0=;
  b=Sqy+70IBk2pC7UQlQLMlVInsTb+0F/FaE9tKFWMf/lTUK4OTOrS/0RlY
   A1FgP3cKxZJZkBvuzL6o4MFF5YcTa+t2Lb62s6p+FJ+70QcFPi9EUMr0S
   DaTY4zN5rlGBZUQMHp2UoWrlS8csL62Yw07+WsF1sQjf0wGQ9fVPL8qsN
   nzfvjsKT0G6ee+f/cgzXaceR+lLy91RfIRt6oZ9NForIQ8nEdiqgjk6xL
   Jyv6PZHGBDq4jw9+x7ydXQjB+lB6BycIHEwMMHYIk/KsjqiFqrCocUdDK
   HAI6NxUiKDLlXnxe1Kx9WrZGIAl23S6pNgMJBPyweSa2dYgYtJ1ymfJof
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277748072"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277748072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 07:29:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="636855861"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 07:28:43 -0700
Message-ID: <444c88f6-0d4f-9149-b1b8-b07d588258de@intel.com>
Date:   Wed, 8 Jun 2022 17:28:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH -next] mmc: debugfs: Fix file release memory leak
Content-Language: en-US
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liangliang Lu <quic_luliang@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Sayali Lokhande <quic_sayalil@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20220608090152.179395-1-weiyongjun1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220608090152.179395-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/06/22 12:01, Wei Yongjun wrote:
> When using single_open() for opening, single_release() should be
> used instead of seq_release(), otherwise there is a memory leak.
> 
> Fixes: c835a6debf06 ("mmc: debugfs: Add debug fs entry for mmc driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 75e98ec88fb9..fe6808771bc7 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -295,6 +295,7 @@ static const struct file_operations mmc_err_stats_fops = {
>  	.open	= mmc_err_stats_open,
>  	.read	= seq_read,
>  	.write	= mmc_err_stats_write,
> +	.release = single_release,
>  };
>  
>  void mmc_add_host_debugfs(struct mmc_host *host)
> 

