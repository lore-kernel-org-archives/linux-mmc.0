From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sh_mobile_sdhi: support modular mmc-core with non-standard hotplug
Date: Fri, 16 Mar 2012 12:22:23 -0400
Message-ID: <87fwd8bjnk.fsf@laptop.org>
References: <Pine.LNX.4.64.1202271454270.32434@axis700.grange>
	<Pine.LNX.4.64.1203091012150.7852@axis700.grange>
	<CANqRtoQ8GSmX5U-twQjKmHcBv18RBHO_YW8DqBW8myOauebufg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQ8GSmX5U-twQjKmHcBv18RBHO_YW8DqBW8myOauebufg@mail.gmail.com>
	(Magnus Damm's message of "Fri, 9 Mar 2012 22:51:21 +0900")
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 09 2012, Magnus Damm wrote:
> On Fri, Mar 9, 2012 at 6:16 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
>> Currently if a platform wants to implement a non-standard card-detection
>> method, it would need to call tmio_mmc_cd_wakeup(), which is an inline
>> function, calling mmc_detect_change(). For this the platform would have
>> to link mmc_core statically into the kernel, losing the ability to build
>> it as a module. This patch adds a callback to the sh_mobile_sdhi driver,
>> which eliminates this dependency.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>
> Looks good to me, thanks for this!
>
> Acked-by: Magnus Damm <damm@opensource.se>

Pushed to mmc-next for 3.4, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
