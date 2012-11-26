From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 26 (mmc/host/tifm_sd.c)
Date: Mon, 26 Nov 2012 11:43:08 -0800
Message-ID: <50B3C64C.1010801@infradead.org>
References: <20121127011738.9ecd7971a7ea2e3d09a9450d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121127011738.9ecd7971a7ea2e3d09a9450d@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Dubov <oakad@yahoo.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/26/2012 06:17 AM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20121115:
> 


on i386:

drivers/built-in.o: In function `tifm_sd_request':
tifm_sd.c:(.text+0x588f95): undefined reference to `__udivdi3'


somewhere inside tifm_sd_request():

I'm guessing that the call to tifm_sd_set_data_timeout() was
inlined by gcc and it's the divide there that is the problem.

-- 

~Randy
