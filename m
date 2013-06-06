From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: tmio: reset the controller after power-up
Date: Thu, 06 Jun 2013 07:43:00 -0400
Message-ID: <8761xr8ny3.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1304241143460.11670@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1304241143460.11670@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 24 Apr 2013 11:59:19 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, hechtb@gmail.com, Horman Simon <simon@horms.net>, Damm Magnus <magnus.damm@gmail.com>, "^[$B0p5H$5$s^[(B" <jinso.inayoshi@gmail.com>, linux-mmc@vger.kernel.org, Nguyen Hong Ky <nh-ky@jinso.co.jp>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 24 2013, Guennadi Liakhovetski wrote:
> This fixes two reported problems:
> 1. after a system resume the controller isn't functioning until a command
>    runs on a timeout and a controller reset is performed.
> 2. if a card is ejected during a running write operation, its re-insertion
>    isn't detected.
>
> Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> Reported-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This doesn't apply to mmc-next -- please could you rebase/resend?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
