Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D3157468;
	Fri, 31 May 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154600; cv=none; b=U7sKag8BBhgJc7Tw3mcDlV7QtFoNnLCOEvSBa6Z5PjSpZwg+19539lS+ERU8W7SAmHFxGIu+JuMqJn6IxPsJTVfmq00lyj2f6X82A84CE6a2gmPGRc0EqnguBn3cNMzopnJ5OG7VVHRGDm125wYs0NQOb0plwWf2A0xCVZp2l1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154600; c=relaxed/simple;
	bh=9vvs5G5liE33btAhn5wjFIgC/KBiBVDVF48f02ujrb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8rCAB+8mD8F1yTILL0Ui54/PhNMmxmKJuMTnOSGkZXHZOlztPouFgG0JpljixN1uD5InPt3oYDlx0Kycy98txI62eJirOo/7Cx+h/RZWPiupNS6OsGlIJIlw9OXSElIuqhSNyBYWUXnVVs/VVmlQuebFtjvZX9QrBzHiJGw/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6M8kRAX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6M8kRAX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717154599; x=1748690599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vvs5G5liE33btAhn5wjFIgC/KBiBVDVF48f02ujrb4=;
  b=B6M8kRAXJonosDROLWqNgUOtmFtUP4MjPGZTp7hS/G/SBzoqMh/Jx6Et
   GEyXlY5xntlX4IyfJsDxkq9JDjkpf1eTSI6xmn7ZqMa0U6aCuqEHZKq0T
   uS/0l4h7X2biDzsKox7yshTOMrl94mng/m6bQMmIeGKRUUJWBnanBLWw+
   EsoIX85hzixyUSVdK4sE0BTzcNfQvicMqVzI2w0/87asWRijRKS7LPrNa
   dIW7gdzd0PgEqmq9tpyWblFUnjFajrfWI1x0GGrG8l9xzQW/u3l5RCP7V
   PwuLE4WVa0bpFvVcZCGXWhwcr4gyuIK+4+PBRpmI4Gz7XwLL1l5WjUPJA
   w==;
X-CSE-ConnectionGUID: 9bW7sDYbR5W73aKqW/lDng==
X-CSE-MsgGUID: i3zVikn8QGOMwyHfet8s6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24254589"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24254589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:23:18 -0700
X-CSE-ConnectionGUID: clSKXcsER0e51g+aWjoDdA==
X-CSE-MsgGUID: f/bwfbhwSY6onyI2XEPMFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36082388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:23:14 -0700
Message-ID: <84c57084-eb9d-4d11-9c2f-2a4ded6290c6@intel.com>
Date: Fri, 31 May 2024 14:23:09 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error
 Recovery
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com>
 <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
 <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKCRD1Xdb5DmWud9F=r85aVxtnQ5wS_=yhzQ46LS0Mjqsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/05/24 13:31, Victor Shih wrote:
> On Fri, May 24, 2024 at 2:54 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 22/05/24 14:08, Victor Shih wrote:
>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>
>>> Add UHS-II Auto Command Error Recovery functionality
>>> into the MMC request processing flow.
>>
>> Not sure what "auto" means here, but the commit message
>> should outline what the spec. requires for error recovery.
>>
> 
> Hi, Adrian
> 
>      I will add instructions in the v17 version.
> 
> Thanks, Victor Shih
> 
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> ---
>>>
>>> Updates in V16:
>>>  - Separate the Error Recovery mechanism from patch#7 to patch#8.
>>>
>>> ---
>>>
>>>  drivers/mmc/core/core.c    |  4 ++
>>>  drivers/mmc/core/core.h    |  1 +
>>>  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mmc/host.h   |  6 +++
>>>  4 files changed, 91 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 68496c51a521..18642afc405f 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>>>       while (1) {
>>>               wait_for_completion(&mrq->completion);
>>>
>>> +             if (host->ops->get_cd(host))
>>> +                     if (mrq->cmd->error || (mrq->data && mrq->data->error))
>>> +                             mmc_sd_uhs2_error_recovery(host, mrq);
>>
>> There are several issues with this:
>>
>> 1. It is not OK to start a request from within the request path
>> because it is recursive:
>>
>>    mmc_wait_for_req_done()                      <--
>>       mmc_sd_uhs2_error_recovery()
>>          sd_uhs2_abort_trans()
>>             mmc_wait_for_cmd()
>>                mmc_wait_for_req()
>>                   mmc_wait_for_req_done()       <--
>>
>> 2. The mmc block driver does not use this path
>>
>> 3. No need to always call ->get_cd() if there is no error
>>
>> It is worth considering whether the host controller could
>> send the abort command as part of the original request, as
>> is done with the stop command.
>>
> 
> Hi, Adrian
> 
>      1. It looks like just issuing a command in
> mmc_wait_for_req_done() will cause a recursion.
>          I will drop sd_uhs2_abort_trans() and
> sd_uhs2_abort_status_read() in the v17 version.
>      2. I have no idea about this part, could you please give me some advice?

The mmc block driver sets the ->done() callback and so
mmc_wait_for_req_done() is never called for data transfers.

That won't matter if the host controller handles doing
the abort command, as was suggested elsewhere.

>      3. I will try to modify this part in the v17 version.
> 
> Thanks, Victor Shih
> 
>>> +
>>>               cmd = mrq->cmd;
>>>
>>>               if (!cmd->error || !cmd->retries ||
>>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>>> index 920323faa834..259d47c8bb19 100644
>>> --- a/drivers/mmc/core/core.h
>>> +++ b/drivers/mmc/core/core.h
>>> @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
>>>  int mmc_attach_sd(struct mmc_host *host);
>>>  int mmc_attach_sdio(struct mmc_host *host);
>>>  int mmc_attach_sd_uhs2(struct mmc_host *host);
>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq);
>>>
>>>  /* Module parameters */
>>>  extern bool use_spi_crc;
>>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
>>> index 85939a2582dc..d5acb4e6ccac 100644
>>> --- a/drivers/mmc/core/sd_uhs2.c
>>> +++ b/drivers/mmc/core/sd_uhs2.c
>>> @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>>>
>>>       return err;
>>>  }
>>> +
>>> +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
>>> +{
>>> +     struct mmc_request mrq = {};
>>> +     struct mmc_command cmd = {0};
>>> +     struct uhs2_command uhs2_cmd = {};
>>> +     int err;
>>> +
>>> +     mrq.cmd = &cmd;
>>> +     mmc->ongoing_mrq = &mrq;
>>> +
>>> +     uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
>>> +                       mmc->card->uhs2_config.node_id;
>>> +     uhs2_cmd.arg = ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
>>> +                     UHS2_NATIVE_CMD_WRITE |
>>> +                     (UHS2_DEV_CMD_TRANS_ABORT >> 8);
>>> +
>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
>>> +     err = mmc_wait_for_cmd(mmc, &cmd, 0);
>>> +
>>> +     if (err)
>>> +             pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
>>> +                    mmc_hostname(mmc), __func__, err);
>>> +}
>>> +
>>> +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
>>> +{
>>> +     struct mmc_request mrq = {};
>>> +     struct mmc_command cmd = {0};
>>> +     struct uhs2_command uhs2_cmd = {};
>>> +     int err;
>>> +
>>> +     mrq.cmd = &cmd;
>>> +     mmc->ongoing_mrq = &mrq;
>>> +
>>> +     uhs2_cmd.header = UHS2_NATIVE_PACKET |
>>> +                       UHS2_PACKET_TYPE_CCMD |
>>> +                       mmc->card->uhs2_config.node_id;
>>> +     uhs2_cmd.arg = ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
>>> +                     UHS2_NATIVE_CMD_READ |
>>> +                     UHS2_NATIVE_CMD_PLEN_4B |
>>> +                     (UHS2_DEV_STATUS_REG >> 8);
>>> +
>>> +     sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
>>> +     err = mmc_wait_for_cmd(mmc, &cmd, 0);
>>> +
>>> +     if (err)
>>> +             pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
>>> +                    mmc_hostname(mmc), __func__, err);
>>> +}
>>> +
>>> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq)
>>> +{
>>> +     mmc->ops->uhs2_reset_cmd_data(mmc);
>>
>> The host controller should already have done any resets needed.
>> sdhci already has support for doing that - see host->pending_reset
>>
> 
> Hi, Adrian
> 
>      I'm not sure what this means. Could you please give me more information?

sdhci_uhs2_request_done() checks sdhci_needs_reset() and does
sdhci_uhs2_reset().

sdhci_needs_reset() does not cater for data errors because
the reset for data errors is done directly in what becomes
__sdhci_finish_data_common().

You may need to:
 1. add a parameter to __sdhci_finish_data_common() to
 skip doing the sdhci reset and instead set
 host->pending_reset
 2. amend sdhci_uhs2_request_done() to check for data error
 also to decide if a reset is needed

> 
> Thanks, Victor Shih
> 
>>> +
>>> +     if (mrq->data) {
>>> +             if (mrq->data->error && mmc_card_uhs2(mmc)) {
>>> +                     if (mrq->cmd) {
>>> +                             switch (mrq->cmd->error) {
>>> +                             case ETIMEDOUT:
>>> +                             case EILSEQ:
>>> +                             case EIO:
>>> +                                     sd_uhs2_abort_trans(mmc);
>>> +                                     sd_uhs2_abort_status_read(mmc);
>>
>> What is the purpose of sd_uhs2_abort_status_read() here?
>> It is not obvious it does anything.
>>
> 
> Hi, Adrian
> 
>      sd_uhs2_abort_status_read() seems to only have read status,
>      I will drop this in the v17 version.
> 
> Thanks, Victor Shih
> 
>>> +                                     break;
>>> +                             default:
>>> +                                     break;
>>> +                             }
>>> +                     }
>>> +             }
>>> +     } else {
>>> +             if (mrq->cmd) {
>>> +                     switch (mrq->cmd->error) {
>>> +                     case ETIMEDOUT:
>>> +                             sd_uhs2_abort_trans(mmc);
>>> +                             break;
>>> +                     }
>>> +             }
>>> +     }
>>> +}
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index fc9520b3bfa4..c914a58f7e1e 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -271,6 +271,12 @@ struct mmc_host_ops {
>>>        * negative errno in case of a failure or zero for success.
>>>        */
>>>       int     (*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
>>> +
>>> +     /*
>>> +      * The uhs2_reset_cmd_data callback is used to excute reset
>>> +      * when a auto command error occurs.
>>> +      */
>>> +     void    (*uhs2_reset_cmd_data)(struct mmc_host *host);
>>>  };
>>>
>>>  struct mmc_cqe_ops {
>>

