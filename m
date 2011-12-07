From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [Fwd: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers
	default	queue]
Date: Wed, 7 Dec 2011 16:20:35 +0000
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF402BA5E@DBDE01.ent.ti.com>
References: <4EDF061F.7080302@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4EDF061F.7080302-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Heiko,

On Wed, Dec 07, 2011 at 11:52:23, Heiko Schocher wrote:
> Hello Sekhar,
> 
> here the forwarded comment from Ido Yariv to my patch. I tried
> with current kernel MMC Controller 2 on my am1808 based board
> without my fix, and it works fine, so no need for applying my
> patch.
> 
> Thanks
> bye,
> Heiko
> 
> here the message from Ido:
> 
> Betreff: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
> Datum: Mon, 5 Dec 2011 10:35:10 +0200
> Von: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
> An: hs-ynQEQJNshbs@public.gmane.org
> CC: juha.kuikka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

I think Ido replied to only you and Juha, that's why even I am not able to see his reply on the list.

> Referenzen: <1322991210-20486-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>	<20111204102741.GL32400@WorkStation>	<4EDC7C00.30603-ynQEQJNshbs@public.gmane.org>
> 
> Hi Heiko,
> 
> On Dec 5, 2011 10:08 AM, "Heiko Schocher" <hs-ynQEQJNshbs@public.gmane.org> wro
> > Ok ... patch not longer needed, but isn't it better to setup here
> > immediately the right values? If so, I can sent a v2 with your
> > suggested comment change.
> 
> These are just default values which will get overwritten later on, so im
> not sure if it matters much. I guess it wouldn't hurt to use default_queue
> instead of queue 1.
> 

It would have helped if you posted the complete message here but I figured
this out. I assume that Ido's explanation is as below:

EDMA channel is allocated in MMC driver through the call to
edma_alloc_channel() api and the last argument passed to this api is the
event queue number. Currently the event queue number being passed is
EVENTQ_DEFAULT. Inside edma_alloc_channel() there is a call to
map_dmach_queue() which also takes event queue number as argument.
map_dmach_queue() function initializes the event queue number to
default_queue (being passed from platform data), if it is EVENTQ_DEFAULT.

I wanted to know why MMC/SD was not working initially for you even with
this piece of code? 

> In any case, if you do chose to submit v2, the commit message should also
> be changed if it doesnt really fix anything.

I would still say, your patch is the clean way of addressing the issue.
May be you can modify the commit message as Ido has pointed out.

Sekhar, do you have any comments?

Thanks,
Sudhakar
