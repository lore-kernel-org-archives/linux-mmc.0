Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44EEC43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C668217BA
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJHJpG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:45:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJHJpG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 05:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92521042;
        Thu,  8 Oct 2020 02:45:05 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CF63F70D;
        Thu,  8 Oct 2020 02:45:04 -0700 (PDT)
Date:   Thu, 8 Oct 2020 10:45:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     muhammad.husaini.zulkifli@intel.com
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        lakshmi.bai.raja.subramanian@intel.com, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: Re: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Message-ID: <20201008094501.ix2sdxorwhxchy5w@bogus>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 08, 2020 at 10:09:33AM +0800, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Add header file to handle API function for device driver to communicate
> with Arm Trusted Firmware.

[nit] Since it moved to trusted-firmware.org, it is no longer "Arm"
Trusted Firmware. It is now called Trusted Firmware - A profile(TF-A)
or Trusted Firmware - M profile (TF-M). Please update the subject and
the text above. I know it is silly but I am being asked to get this
fixed as it may create "confusion"(I don't know details, please don't
ask 😁)

Apart from various minor things Andy already pointed out, this looks
good. You can add by Ack once the above naming and all things pointed
by Andy are fixed.

--
Regards,
Sudeep
