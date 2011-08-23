From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 13:36:58 -0400
Message-ID: <m2wre42fnp.fsf@bob.laptop.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
	<1314114363-6767-3-git-send-email-svenkatr@ti.com>
	<m27h643x8k.fsf@bob.laptop.org>
	<20110823165620.GA9132@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
In-Reply-To: <20110823165620.GA9132@merkur.ravnborg.org> (Sam Ravnborg's
	message of "Tue, 23 Aug 2011 18:56:20 +0200")
Sender: linux-sparse-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 23 2011, Sam Ravnborg wrote:
>> So we're not assigning 0 to a pointer, or whatever sparse thinks we're
>> doing -- we're initializing every member of the struct with 0, which is
>> a good and safe way to initialize it.
>> 
>> Sparse folks, any comment?
>
> The struct looks like this:
> struct mmc_request {
>         struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
>         struct mmc_command      *stop;
>
>         struct completion       completion;
>         void (*done)(struct mmc_request *);/* completion function */
> };
>
>
> So you assing '0' to sbc - which is a pointer.
> So sparse warning is correct.

Oops, thanks Sam, I should have realized this was the complaint --
sorry for wasting your time.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
