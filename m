From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Linux v3.1-rc8 : SDHC card do not switch to high speed mode
Date: Tue, 18 Oct 2011 11:41:03 +0530
Message-ID: <000301cc8d5c$b9deb630$2d9c2290$@org>
References: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF6E@dbde02.ent.ti.com>	<19F8576C6E063C45BE387C64729E739404ECE22D47@dbde02.ent.ti.com>	<6C03668EAF45B747AF947A1603D1B30001E3579366@SAUSEXMBP01.amd.com>	<19F8576C6E063C45BE387C64729E739404ECE22DBA@dbde02.ent.ti.com>	<000001cc8d59$3af39730$b0dac590$@org> <m27h426e56.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <m27h426e56.fsf@bob.laptop.org>
Content-Language: en-us
Sender: linux-omap-owner@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: "'Hiremath, Vaibhav'" <hvaibhav@ti.com>, "'Nath, Arindam'" <Arindam.Nath@amd.com>, "'Hebbar, Gururaja'" <gururaja.hebbar@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, prakity@marvell.com, zhangfei.gao@marvell.com, "'Saxena, Parth'" <parth.saxena@ti.com>
List-Id: linux-mmc@vger.kernel.org

Chris,

I had already posted the proper patch with signed off:
http://permalink.gmane.org/gmane.linux.ports.arm.msm/1875

Regards,
Subhash

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, October 18, 2011 11:22 AM
> To: Subhash Jadavani
> Cc: 'Hiremath, Vaibhav'; 'Nath, Arindam'; 'Hebbar, Gururaja'; linux-
> mmc@vger.kernel.org; linux-omap@vger.kernel.org; prakity@marvell.com;
> zhangfei.gao@marvell.com; 'Saxena, Parth'
> Subject: Re: Linux v3.1-rc8 : SDHC card do not switch to high speed
> mode
> 
> Hi Subhash,
> 
> On Tue, Oct 18 2011, Subhash Jadavani wrote:
> > Arindam,
> > No, I had not posted the final version of the patch. Chris wanted to
> use
> > some macros instead of magic numbers.
> > One mentioned by Vaibhav
> > (http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg09358.html)
> is the
> > last patch.
> 
> If you provide a Signed-off-by: for your original patch, I'll go ahead
> and merge it now.  Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

