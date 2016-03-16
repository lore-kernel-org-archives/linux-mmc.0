From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Wed, 16 Mar 2016 13:32:09 +0100
Message-ID: <CAPDyKFpXk8r1mQzUkYD9vBYEtzvaO07f1WnfST2897xYkBpcPg@mail.gmail.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
	<1456479257-12147-1-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFrvaLq3dD5qFJBLVTL5gXA9NaHxfc_mM9PCfczfwQiJLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35306 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbcCPMcL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 08:32:11 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so186897727wml.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 05:32:10 -0700 (PDT)
In-Reply-To: <CAPDyKFrvaLq3dD5qFJBLVTL5gXA9NaHxfc_mM9PCfczfwQiJLA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Lucas Stach <dev@lynxeye.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 4 March 2016 at 10:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 February 2016 at 10:34, Jon Hunter <jonathanh@nvidia.com> wrote:
>> SD card support for Tegra114 started failing after commit a8e326a911d3
>> ("mmc: tegra: implement module external clock change") was merged. This
>> commit was part of a series to enable UHS-I modes for Tegra. To
>> workaround this problem for now, disable UHS-I modes for Tegra114 by
>> separating the soc data structures for Tegra114 and Tegra124 so that
>> UHS-I is still enabled for Tegra124 but not Tegra114.
>>
>> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>
> Thanks, applied for fixes!

Unfortunate I failed to send this in a PR to Linus within the 4.5 rc
cycle, apologize for the inconvenience!
Instead I have this queued for 4.6 and I have added a stable tag to it.

[...]

Kind regards
Uffe
