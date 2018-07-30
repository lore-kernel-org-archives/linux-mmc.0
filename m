From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Mon, 30 Jul 2018 11:11:33 +0800
Message-ID: <20180730111133.0b4e8b2d@xhacker.debian>
References: <20180730104228.28b58bd0@xhacker.debian>
        <20180730104636.1a3e6c81@xhacker.debian>
        <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
        <20180730105954.6c365a7b@xhacker.debian>
        <01010164e92bcc1a-c3ac69eb-f6e5-4420-ac87-de1a0ffd0ac5-000000@us-west-2.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01010164e92bcc1a-c3ac69eb-f6e5-4420-ac87-de1a0ffd0ac5-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Leon <matthewleon@linux.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 30 Jul 2018 03:11:59 +0000
Matthew Leon <matthewleon@linux.com> wrote:

>  >> Hey Jisheng,  
> 
> >Hi,  
> 
> >>  
> 
> >In LKML, we'd better not top post.  
> 
> Noted. My apologies.
> 
> >> Shouldn't we be splitting until all DMA blocks are less than 128M  
> boundary?
> >> I am a noob, but I think we should be prepared for boundaries that when
> >> split in two, will still be greater than 128M. Feel free to disagree but
> >> please explain why I may be wrong. Thank-you.  
> 
> >the limitation is "DMA addr can't span 128MB boundary" rather than "must be
> >less than 128MB", they are different.  
> 
> >And the max transfer size of one DMA desc is 64KB.  
> 
> >thanks  
> 
> I have misspoken. What if the DMA transfer size is 1024M? If we split in
> two, then we have 2 transfers, each of which span 512M. So wouldn't we need
> to split again to have 4 transfers, each of which span 128M?
> 

the max transfer size of each desc is 64KB, how could it be 1024MB?
