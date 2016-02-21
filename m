From: Sascha Sommer <saschasommer@freenet.de>
Subject: Re: [PATCH 2/2] mmc-sdricoh_cs: Less checks in sdricoh_init_mmc()
 after, error detection
Date: Sun, 21 Feb 2016 10:15:53 +0100
Message-ID: <20160221101553.7fd64e70@madeira.sommer.dynalias.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<5682F3AC.7050107@users.sourceforge.net>
	<5682F4ED.4070803@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5682F4ED.4070803@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-mmc@vger.kernel.org

Hello,

Am Tue, 29 Dec 2015 22:02:37 +0100
schrieb SF Markus Elfring <elfring@users.sourceforge.net>:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 29 Dec 2015 21:45:34 +0100
> 
> This issue was detected by using the Coccinelle software.
> 
> Two pointer checks could be repeated by the sdricoh_init_mmc()
> function during error handling even if the relevant properties can be
> determined for the involved variables before by source code analysis.
> 
> * This implementation detail could be improved by adjustments
>   for jump targets according to the Linux coding style convention.
> 
> * Drop an unnecessary initialisation for the variable "mmc" then.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Sascha Sommer <saschasommer@freenet.de>

Best regards

Sascha
