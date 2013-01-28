From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: host: add SDHCI platform driver for msm chipsets
Date: Mon, 28 Jan 2013 16:05:13 -0500
Message-ID: <87obg981di.fsf@laptop.org>
References: <1357712243-486-1-git-send-email-asutoshd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1357712243-486-1-git-send-email-asutoshd@codeaurora.org>
	(Asutosh Das's message of "Wed, 9 Jan 2013 11:47:23 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Asutosh Das <asutoshd@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Asutosh,

On Wed, Jan 09 2013, Asutosh Das wrote:
> This platform driver adds the support of Secure Digital Host
> Controller Interface compliant controller in MSM chipsets.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>

Please resubmit (or just let me know) this patch once the SoC that
contains this IP has mainline support queued for merging.

Also, please switch to using the standard MMC DT bindings where possible
instead of the qcom,-prefixed ones.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
