From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Thu, 7 Jun 2012 15:50:55 +0530
Message-ID: <000501cd4497$3b31ead0$b195c070$@codeaurora.org>
References: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>	<87pqbfv3e1.fsf@laptop.org>	<000201cd174a$f3019b80$d904d280$@codeaurora.org>	<000301cd1d22$57444d40$05cce7c0$@codeaurora.org>	<CAKYAXd9QfEEJLQGG6PJgnNyyXP4D2Sa-PqhiZ=dDdQv50z76+A@mail.gmail.com>	<000001cd35af$2eae5ba0$8c0b12e0$@codeaurora.org> <87mx4g4lft.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <87mx4g4lft.fsf@octavius.laptop.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 'Namjae Jeon' <linkinjeon@gmail.com>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, June 06, 2012 7:01 PM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; 'Namjae
> Jeon'
> Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with
> blk_end_request()
> 
> Hi,
> 
> On Sat, May 19 2012, Subhash Jadavani wrote:
> > Do you see any issues with this patch?
> 
> No, no issues -- please could I ask you to refresh it against 3.5-rc1 (it
no longer
> applies) and add your performance numbers to the commit message?  I'll
push
> it to mmc-next and probably merge for 3.6, so that we have a full round of
> linux-next for anyone to notice problems.

Thanks Chris. I have posted v2 of this patch against mmc-next tip.

Regards,
Subhash

> 
> Thanks!
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
