From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Thu, 13 Aug 2015 08:59:36 +0900
Message-ID: <20150812235935.GB5221@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <28226759.dUa3lFkaxJ@wasted.cogentembedded.com>
 <20150812005901.GF15957@verge.net.au>
 <55CB220A.5040209@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55CB220A.5040209@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

[CC: Ulrich, Geert]

On Wed, Aug 12, 2015 at 01:38:02PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 8/12/2015 3:59 AM, Simon Horman wrote:
> 
> >>Renesas R8A7794 SoC also has the MMCIF controller...
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >This new compat string looks good to me.
> 
> >Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
>    Thank you. I've messed up the subject, so need to re-post.
> 
> >>---
> >>The patch is against Ulf Hansson's 'mmc.git'  repo's 'next' branch plus the
> >>patch I posted earlier today...
> >>
> >>Changes in version 2:
> >>- deferred R8A7793 support to the patch posted earlier by Ulrich Hecht;
> 
> >Perhaps it would be best to co-ordinate the R8A7793 and R8A7794
> >changes to avoid tedious conflicts.
> 
>    I thought about taking out Ulrich's binding patch and re-posting it
>    along with this one but finally decided not to ruin his series. Do you
>    mean that I should have posted his patch along with mine?

I mean we sould talk about this to come up with a plan that makes things
easy for the maintainer to pick up the compat strings for the R8A7793 and
R8A7794.
