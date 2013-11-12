From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [RFC/PATCH 0/2] mmc: sdhci: Workaround Intel Merrifield issue
 for HS200
Date: Tue, 12 Nov 2013 13:49:09 -0800
Message-ID: <5282A255.5090904@linux.intel.com>
References: <1383069507-27574-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60289 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182Ab3KLVoj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Nov 2013 16:44:39 -0500
In-Reply-To: <1383069507-27574-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuanxiao.dong@intel.com

On 10/29/2013 10:58 AM, David Cohen wrote:
> Hi,
>
> SDHCI used to work well on Intel Merrifield until this patch was applied:
>
> commit 156e14b126ffb6f040bc6f1aff3c51077e42a744
> Author: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
> Date:   Wed Jun 12 08:16:38 2013 +0200
>
>      mmc: sdhci: fix caps2 for HS200
>
>      Although the HC supports HS200 (eMMC) the caps2 are always zero; this
>      means there's no way to use the super speed mode (when init the card).
>
>      If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC
>      and this patch just sets the MMC_CAP2_HS200 in the host caps2 field.
>
> Looks like there is a hw issue with unknown root cause so far.
>
> Is it acceptable to have the quirk I'm proposing to workaround the issue?

Ping. Any comments here?

Br, David Cohen
