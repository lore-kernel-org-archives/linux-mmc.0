From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next] mmc: sh_mmcif: Document r8a73a4, r8a7779 and
 sh73a0 DT bindings
Date: Fri, 25 Nov 2016 08:56:34 +0100
Message-ID: <20161125075634.GC14431@verge.net.au>
References: <1480011435-22125-1-git-send-email-horms+renesas@verge.net.au>
 <e0e1d92b-1b79-ec53-def0-25a080edc073@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0e1d92b-1b79-ec53-def0-25a080edc073@cogentembedded.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 24, 2016 at 09:50:38PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/24/2016 09:17 PM, Simon Horman wrote:
> 
> >Simply document new compatibility strings as the driver is already
> >activated using a fallback compatibility string.
> >
> >These compat strings are in keeping with those for all other
> >Renesas ARM based SoCs with sh_mmcif enabled in mainline.
> >
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >I plan to follow-up with patches to use these new compat strings
> >to bring the DT files of the SoCs in question in-line with those
> >for other Renesas ARM based SoCs with sh_mmcif enabled in mainline.
> >---
> > Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >index ff611fa66871..e4ba92aa035e 100644
> >--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> >@@ -8,11 +8,14 @@ Required properties:
> >
> > - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
> >   fallback. Examples with <soctype> are:
> >+	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
> > 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> >+	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
> 
>    7779 in the subject, 7778 here.

Thanks, I have reposted with an updated subject.
