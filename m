From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH/RFC] usb: fix renesas_usbhs to not schedule
 in atomic context
Date: Mon, 06 Feb 2012 17:52:33 +0900
Message-ID: <4F2F94D1.1080308@renesas.com>
References: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
	<1327589784-4287-2-git-send-email-g.liakhovetski@gmx.de>
	<4F22624E.2090201@renesas.com>
	<Pine.LNX.4.64.1201270946150.32661@axis700.grange>
	<4F27CA7D.601@renesas.com>
	<Pine.LNX.4.64.1202022317560.13860@axis700.grange>
	<4F2B9F34.60308@renesas.com>
	<Pine.LNX.4.64.1202031623000.6211@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <Pine.LNX.4.64.1202031623000.6211@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi-san,

2012/02/04 0:43, Guennadi Liakhovetski wrote:
> The current renesas_usbhs driver triggers
> 
> BUG: scheduling while atomic: ksoftirqd/0/3/0x00000102
> 
> with enabled CONFIG_DEBUG_ATOMIC_SLEEP, by submitting DMA transfers from 
> an atomic (tasklet) context, which is not supported by the shdma dmaengine 
> driver. Fix it by switching to a work. Also simplify some list 
> manipulations.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Shimoda-san, this is the problem, that you were observing. However, it 
> exists with the present version of shdma just as well as with the new one 
> - on top of the simple DMA library. I marked it an RFC because (1) I only 
> lightly tested it with the gadget device on mackerel with the mass storage 
> gadget, and (2) I am somewhat concerned about races. Currently the work 
> function runs with no locking and there are no usual cancel_work_sync() 
> points in the patch. However, it has also been like this before with the 
> tasklet implementation, which is not much better, and it looks like there 
> are no asynchronous operations on the same packets like timeouts. Only 
> asynchronous events, that I can think about are things like unloading the 
> driver or unplugging the cable, but these have been there before too. It 
> would become worse on SMP, I think. Comments welcome.

Thank you for the patch and comments.
I also tested this patch using the g_mass_storage and g_ether.
About your points, I think so, too.
So, I will write such a code.

Best regards,
Yoshihiro Shimoda
