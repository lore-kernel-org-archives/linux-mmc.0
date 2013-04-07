From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/5] mmc: core: call pm_runtime_put_sync in
 pm_runtime_get_sync failed case
Date: Sun, 7 Apr 2013 13:39:15 +0300
Message-ID: <CAK=Wgbb1_CgHpftEFmuqSKcCSjsjvyNCWEYNzQwC4vQKteaerQ@mail.gmail.com>
References: <1362037031.6212.3.camel@fli24-HP-Compaq-8100-Elite-CMT-PC> <1362037455.6212.8.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:43345 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254Ab3DGKjh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 06:39:37 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so4924925lbi.29
        for <linux-mmc@vger.kernel.org>; Sun, 07 Apr 2013 03:39:35 -0700 (PDT)
In-Reply-To: <1362037455.6212.8.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Li Fei <fei.li@intel.com>
Cc: Chris Ball <cjb@laptop.org>, ulf.hansson@linaro.org, johan.rudholm@stericsson.com, subhashj@codeaurora.org, Philip Rakity <prakity@marvell.com>, rafael.j.wysocki@intel.com, thierry.reding@avionic-design.de, sachin.kamat@linaro.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>

Hi Li,

On Thu, Feb 28, 2013 at 9:44 AM, Li Fei <fei.li@intel.com> wrote:
> Even in failed case of pm_runtime_get_sync, the usage_count
> is incremented. In order to keep the usage_count with correct
> value and runtime power management to behave correctly, call
> pm_runtime_put(_sync) in such case.

As with the remoteproc case, it is probably better to call the
put_noidle variant here. This way you are sure not to erroneously
invoke any underlying pm handler where your only intention is to fix
usage_count.

Thanks,
Ohad.
