From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 07/12] mmc: sh_mmcif: Convert to clk_prepare/unprepare
Date: Thu, 31 Oct 2013 00:48:47 +0100
Message-ID: <14289582.5zfRMUTTcX@avalon>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2522233.ixtrcdiJKv@avalon> <CAPDyKFoNn9g2RmGvFnmDYfiOhZHQYY33zA=Rk5DQWEBNDyhfHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46805 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab3J3XsX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 19:48:23 -0400
In-Reply-To: <CAPDyKFoNn9g2RmGvFnmDYfiOhZHQYY33zA=Rk5DQWEBNDyhfHQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Uluf,

On Thursday 31 October 2013 00:27:23 Ulf Hansson wrote:
> On 31 October 2013 00:13, Laurent Pinchart wrote:
> > On Wednesday 30 October 2013 23:23:37 Guennadi Liakhovetski wrote:
> >> On Tue, 29 Oct 2013, Guennadi Liakhovetski wrote:
> >> > On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> >> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> >> > > and clk_disable_unprepare() to get ready for the migration to the
> >> > > common clock framework.
> >> > > 
> >> > > Cc: Chris Ball <cjb@laptop.org>
> >> > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >> > > Cc: linux-mmc@vger.kernel.org
> >> > > Signed-off-by: Laurent Pinchart
> >> > > <laurent.pinchart+renesas@ideasonboard.com>
> >> > 
> >> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> 
> >> Sorry, I just realised, that an identical patch
> >> 
> >> http://patches.linaro.org/21212/
> >> 
> >> has been submitted prior to this one, so, we should really take the other
> >> one.
> > 
> > I'm fine with that, as long as one of the two patches hit mainline as soon
> > as possible.
> 
> I can put together a new pull request for Chris asap, but in the end
> it will be his call to take it now or later.

That would be great. It can wait for v3.14 though, but having the patch in 
v3.13 would be nice.

-- 
Regards,

Laurent Pinchart

