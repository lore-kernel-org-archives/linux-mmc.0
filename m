From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 08/16] mmc: sdhci-omap: Add support to override f_max
 and iodelay from pdata
Date: Fri, 16 Feb 2018 13:38:51 +0530
Message-ID: <d381abaf-8968-ae0f-7dd3-8c10e7220648@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-9-kishon@ti.com>
 <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
 <20180214172455.GO6364@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:55287 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753922AbeBPIJ3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Feb 2018 03:09:29 -0500
In-Reply-To: <20180214172455.GO6364@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

On Wednesday 14 February 2018 10:54 PM, Tony Lindgren wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [180214 09:53]:
>> On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
>>> versions of EVM can come with either revision 1.1 or revision 1.0 of
>>> silicon.
>>>
>>> The device-tree file is written to support rev 2.0 of silicon.
>>> pdata-quirks are used to then override the settings needed for
>>> PG 1.1 silicon.
>>>
>>> PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
>>> can operate as well as different IOdelay numbers.
>>
>> I fail to understand the need for platform data. Why can't DT be used
>> for the older revisions as well?

It was decided to have dt file for a single soc revision. So the default dts
corresponds to rev 2.0.
> 
> Maybe the silicon revision is not available via soc_device_match()?

hmm.. looks like we can get rid of pdata if we use soc_device_match. Thanks for
the hint.

Regards
Kishon
