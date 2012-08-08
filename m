From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA
	segment len to 1 for bf518.
Date: Tue, 07 Aug 2012 23:36:49 -0400
Message-ID: <87vcguvyum.fsf@octavius.laptop.org>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
	<CAJxxZ0M9oReELfJ_ncu=eHd=Qy0Bpx=06Jv3MzvOPbRTh_h-jg@mail.gmail.com>
	<87zk66vz45.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <87zk66vz45.fsf-DGHOrqG7t0YzNDMTQreKSUB+6BGkLq7r@public.gmane.org> (Chris Ball's message of
	"Tue, 07 Aug 2012 23:31:06 -0400")
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bob Liu <liubbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 07 2012, Chris Ball wrote:
> On Tue, Aug 07 2012, Sonic Zhang wrote:
>> Could you review this series of patches for Blackfin on-chip SD
>> controller? The head file and new BF60x machine code have been merged
>> upstream. These patches are necessary to get SD driver built on BF60x.
>
> I see that Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org> is listed as the maintainer
> of bfin_sdh.c in MAINTAINERS -- is it possible for you to get his ACK?

Ah, Cliff's e-mail address bounced, and I see this was noticed last
November -- you said you'd send out a MAINTAINERS update.  Are you
planning on taking over as bfin_sdh maintainer?

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
