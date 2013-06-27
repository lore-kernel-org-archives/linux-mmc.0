From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH (v2)] mmc: sdhci: fix caps2 for HS200
Date: Thu, 27 Jun 2013 11:50:21 -0400
Message-ID: <8738s3o8n6.fsf@octavius.laptop.org>
References: <DC90B37F-FB8C-4A1E-AACF-82CE5D53B95C@nvidia.com>
	<1371017798-4144-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44786 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036Ab3F0Pu1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:50:27 -0400
In-Reply-To: <1371017798-4144-1-git-send-email-peppe.cavallaro@st.com>
	(Giuseppe CAVALLARO's message of "Wed, 12 Jun 2013 08:16:38 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@nvidia.com>

Hi Giuseppe,

On Wed, Jun 12 2013, Giuseppe CAVALLARO wrote:
> Although the HC supports HS200 (eMMC) the caps2 are always zero; this means that
> no way to use the super speed mode (when init the card).
>
> If the HC support SDR104, for SD3.0, so it also supports HS200 for eMMC and
> this patch just sets the MMC_CAP2_HS200 in the host caps2 field.
>
> v2: Since SDR104 and HS200 are effectively the same thing the patch deletes
> the defines for HS200 and use SDR104.
>
> Reported-by: Youssef Triki <youssef.triki@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Philip Rakity <prakity@nvidia.com>

Thanks, pushed v2 to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
