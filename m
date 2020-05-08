Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8341C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64C8218AC
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 18:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHSxZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 14:53:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:45830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgEHSxZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 May 2020 14:53:25 -0400
IronPort-SDR: t2NhjdtKD1C0ui0gvvbGc4l8+DP6coTvLiGfsadS+UsoHZftn4+Q9v7sKcpdIbvXNeHoyk9GCc
 Wjg2KeckmrwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 11:53:25 -0700
IronPort-SDR: zpYGNPvzGIadTMK2KjfsDTiMJipm2GatPIjTYYshXEV+5xjZqMyL7XO7CFkCxicC2VMo1rxd43
 dmXniXknVPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="250546716"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 08 May 2020 11:53:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX87i-005SnH-Et; Fri, 08 May 2020 21:53:26 +0300
Date:   Fri, 8 May 2020 21:53:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Joerg Roedel <jroedel@suse.de>, linux-mmc@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>,
        Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
Message-ID: <20200508185326.GN185537@smile.fi.intel.com>
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de>
 <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
 <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 08, 2020 at 10:59:37AM -0600, Raul Rangel wrote:
> It looks like the ACPI matching logic was changed.
> 
> With ToT we get:
> ```
> [   13.099631] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
> Checking ACPI HID Map.
> [   13.108542] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
> p->hid: AMDI0040, p->uid: .
> [   13.117936] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id: No match!
> ```
> 
> If I revert [iommu/amd: Switch to use
> acpi_dev_hid_uid_match()](https://github.com/torvalds/linux/commit/ae5e6c6439c3d0ac8e9c71523790ba1ff6887894)
> the matching works.

Thank you for report.

It seems the _UID() in case of matching is present and not empty ("0" vs. "").
The question is why we have no UID is not there?

I will look at it later.

The quick fix looks like

-		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid, *p->uid ? p->uid : NULL)) {

Can you test it?

> ```
> [   13.275305] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
> Checking ACPI HID Map.
> [   13.284216] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id:
> p->hid: AMDI0040, p->uid: .
> [   13.293610] platform AMDI0040:00: AMD-Vi: match_hid_uid: dev->hid:
> AMDI0040, dev->uid: 0.
> [   13.302715] platform AMDI0040:00: AMD-Vi: get_acpihid_device_id: Found match!
> ```
> 
> We can see the device is now associated with a group:
> 
> ```
> # find /sys/ -iname iommu
> /sys/devices/platform/AMDI0040:00/iommu
> ```
> 
> ```
> # cat /sys/devices/platform/AMDI0040\:00/iommu_group/reserved_regions
> 0x00000000fee00000 0x00000000feefffff msi
> 0x000000fd00000000 0x000000ffffffffff reserved
> ```

-- 
With Best Regards,
Andy Shevchenko


