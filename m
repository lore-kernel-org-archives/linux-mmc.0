From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for
 further SoCs
Date: Tue, 9 Jul 2013 18:06:00 +0900
Message-ID: <CANqRtoQY7hwEhN5XMXG5V234aXDFZ_kfei8ZQL+VMKaaxW=0DQ@mail.gmail.com>
References: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 9, 2013 at 4:43 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add further OF compatibility strings to the SDHI driver to be able to
> precisely control driver's behaviour on each of them.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v4:
> 1. added r8a7778 and r8a7779 per Morimoto-san's request
> 2. sh* and r8a* entries now sorted alphabetically

This looks good to me, thanks.

Acked-by: Magnus Damm <damm@opensource.se>
