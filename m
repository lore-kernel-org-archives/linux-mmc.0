Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8FC25B70
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Oct 2023 10:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbjJ0Ky7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Oct 2023 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjJ0Ky6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 06:54:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50188129
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698404096; x=1729940096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=69RkpwK0EJZDbOQqPNYE5notdzn/1hr5bS5Lli/Ct00=;
  b=kqnsFlQ3zpS3U3Fm3ZYf9uh3iP81Jaq5qDnIpcsHQbt3McQzZy/NkiaH
   KjEdWttjI33bg6QjEpdDS34J4+Aeo/+kYhOv2gqBIKAGem+D3iY5tiIA7
   +JcRJoKZnhaVaQEz5XTL5EMSru3rFFlnl4RSycdOcypId7f09gxMOd3H4
   3zzsX2Zple14NCSKEJ3dclCPkJOkHa+vTB7MF3DQWOmI/SKaPxHOpld2M
   rR1Rd5Um7F60xZtRrZuigP5Ei56jgYh5zXjBmtaH3GL9g6FzMS5t6AF3W
   wy8lh1/xwHvbTxoDD0Naw3eXFKXmfn31/kuOdXkehHqK5NcdrsM11iDkP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="384961603"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="384961603"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="903232568"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="903232568"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.41.10])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:52:26 -0700
Message-ID: <77d61d32-70ee-4343-a21e-fae69d2247d7@intel.com>
Date:   Fri, 27 Oct 2023 13:54:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mmc: host: Disable auto-cmd12 during ffu
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
 <afdada50-cdcb-4edb-a026-c872e1914e43@intel.com>
 <DM6PR04MB6575743E1EBDC899206E9A9AFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqHV02EaSMDgLZHG51DT-smhWcc7=EvUG9+N5g7ns1HJg@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqHV02EaSMDgLZHG51DT-smhWcc7=EvUG9+N5g7ns1HJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/10/23 12:41, Ulf Hansson wrote:
> On Thu, 26 Oct 2023 at 12:07, Avri Altman <Avri.Altman@wdc.com> wrote:
>>
>>> On 25/10/23 14:30, Avri Altman wrote:
>>>> Field Firmware Update (ffu) may use close-ended or open ended sequence.
>>>> Each such sequence is comprised of a write commands enclosed between 2
>>>> switch commands - to and from ffu mode.
>>>>
>>>> Some platforms generate auto command error interrupt when it shouldn't,
>>>> e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
>>>> issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook
>>> x2,
>>>> a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
>>>> sure it disable auto-cmd12 while close-ended ffu is in progress.
>>>
>>> I think I misunderstood this because I was thinking that auto-cmd12
>>> was being used with an open-ended sequence, and that it wasn't
>>> working with FFU.  However it seems mmc-utils is using a closed-ended
>>> sequence.
>> Yes, mmc-utils, fwupd, as well as others - uses close-ended,
>> And unlike rpmb - it sends cmd23 as part of the ffu sequence.
>>
>>>
>>> It looks like the the host controller driver doesn't know that,
>>> because the ioctl interface does not use mrq.sbc and the
>>> SET_BLOCK_COUNT command is sent separately.  Then when the
>>> MULTI_WRITE
>>> command is issued, the host controller driver treats it as open-ended
>>> and will enable auto-cmd12 if the controller supports it.
>>>
>>> If that is the case, it would be better to fix the ioctl handling
>>> and make it use mrq.sbc instead of issuing SET_BLOCK_COUNT separately.
>> We can do that.
>> On the other hand, this doesn't happen on other platforms.
>> Fwupd has just recently switched to close-ended, but mmc-utils is using close-ended mode for many years,
>> Performing ffu successfully on many different platforms.
>> My understanding is, that the hw should realize that cmd23 has just sent prior to cmd25 and avoid this auto-cmd12.
> 
> Yes, in principle that's correct.
> 
> In fact, I think that most host drivers should already support this
> behavior, although it relies on the CMD23 to be incorporated within
> the same mmc request (mrq) as the CMD25. We use "mrq.sbc" for this and
> the host driver uses MMC_CAP_CMD23 to inform the MMC core whether it
> supports this or not.
> 
>>
>> Going back to your proposal, we can ignore cmd23 in close-ended ffu, but eventually,
>> we will need to change mmc-utils and fwupd to stop send cmd23.
> 
> This is not what we proposed, at least if I understood Adrian correctly.
> 
> Instead, the idea that could make better sense, is to fix the mmc
> ioctl handling in the mmc core, so that it can discover that a CMD23
> command is followed by another CMD18/25 (multiple read/write). And in
> this case, it should boundle the commands together, using mrq.sbc so
> that one request gets sent to the mmc host driver instead of two.

Yes that is what I was thinking.  Perhaps look at
__mmc_blk_ioctl_cmd() first.  It doesn't have enough information
to decide what to do, so either something needs to be added to
struct mmc_blk_ioc_data and set up before hand, or it needs to
be passed struct mmc_queue_req *mq_rq.

> 
> In this way, there should be no need for any specific changes to any
> of the host drivers (assuming they have the CMD23 support implemented
> correctly), they should just work.
> 
> [...]
> 
> Kind regards
> Uffe

