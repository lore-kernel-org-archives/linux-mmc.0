From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: postpone controller reset during resume
Date: Thu, 06 Jun 2013 07:41:48 -0400
Message-ID: <87ehcf8o03.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1304221025300.23906@axis700.grange>
	<Pine.LNX.4.64.1306060928050.32566@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1306060928050.32566@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 6 Jun 2013 09:30:21 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, hechtb@gmail.com, Horman Simon <simon@horms.net>, Damm Magnus <magnus.damm@gmail.com>, "^[$B0p5H$5$s^[(B" <jinso.inayoshi@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 06 2013, Guennadi Liakhovetski wrote:
> Hi Chris
>
> On Mon, 22 Apr 2013, Guennadi Liakhovetski wrote:
>
>> When resuming, the tmio_mmc_host_resume() function is run when the
>> controller might still be powered down. Issuing a reset command to it at
>> that time has no effect. This patch postpones resetting the controller
>> until the first powering-up .set_ios() call.
>> 
>> Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> Any reason why this hasn't been applied yet? Please, push for 3.10.

Pushed to mmc-next for 3.10, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
