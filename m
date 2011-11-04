From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (V6)
Date: Fri, 04 Nov 2011 15:37:08 +0200
Message-ID: <4EB3EA84.5000806@intel.com>
References: <4EB3A9A4.1000205@intel.com> <1320411199-16860-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31188 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119Ab1KDNhL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 09:37:11 -0400
In-Reply-To: <1320411199-16860-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 04/11/11 14:53, Giuseppe CAVALLARO wrote:
> This patch is to expose the actual SDCLK frequency in
> /sys/kernel/debug/mmcX/ios entry.
> 
> For example, if the max clk for a normal speed card is 20MHz
> this is reported in /sys/kernel/debug/mmcX/ios.
> Unfortunately the actual SDCLK frequency (i.e. Baseclock / divisor)
> is not reported at all: for example, in that case, on Arasan HC,
> it should be 48/4=12 (MHz).
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/debugfs.c |    2 ++
>  drivers/mmc/host/sdhci.c   |   10 ++++++++++
>  include/linux/mmc/host.h   |    2 ++
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
