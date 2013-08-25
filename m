From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for further SoCs
Date: Sun, 25 Aug 2013 00:09:14 -0400
Message-ID: <87fvtyqumt.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
	<CANqRtoQY7hwEhN5XMXG5V234aXDFZ_kfei8ZQL+VMKaaxW=0DQ@mail.gmail.com>
	<20130710011834.GA27240@verge.net.au> <20130717012247.GA2797@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130717012247.GA2797@verge.net.au> (Simon Horman's message of
	"Wed, 17 Jul 2013 10:22:50 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, SH-Linux <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Tue, Jul 16 2013, Simon Horman wrote:
>> Thanks, I have queued this up for v3.12 in the dt branch.
>> It should appear in renesas-next-20130710
>
> Reviewing this, I now think that it should got through the MMC tree.
> Chris, could you consider the patch below?
>
> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> mmc: SDHI: add DT compatibility strings for further SoCs
>
> Add further OF compatibility strings to the SDHI driver to be able to
> precisely control driver's behaviour on each of them.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> Acked-by: Simon Horman <horms@verge.net.au>

Sorry for the delay -- this is in mmc-next for 3.12 now.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
