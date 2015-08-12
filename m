From: Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
Date: Wed, 12 Aug 2015 16:57:27 +0200
Message-ID: <55CB5ED7.40406@schinagl.nl>
References: <cover.1439381423.git.hramrach@gmail.com> <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com> <55CB3D92.6040403@redhat.com> <55CB47D8.4010207@schinagl.nl> <CAOMqctSdkPgDfBCNsGNsNnoh4GqVW59oZC3q9HX3gY_NneMPKw@mail.gmail.com>
Reply-To: oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDDZ7YMYRMGBBWN5VWXAKGQEIZQ4UUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAOMqctSdkPgDfBCNsGNsNnoh4GqVW59oZC3q9HX3gY_NneMPKw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The thing is, I never saw the prints in my console (i assume that it 
prints on the console by default with earlyprintk/debug stuff enabled as 
per sunxi-usual)?

P.S. what I do as a basic test, is on our very very minimal empty debian 
image (think < 150 mb) i do a apt-get build-essential that installs 
about 150mb worth of packages.

Without these patches, everything works as before. All packages 
successfully installed. I can do more intense testing later, but I 
figured that this is pretty intense.

Olliver

On 12-08-15 15:37, Michal Suchanek wrote:
> On 12 August 2015 at 15:19, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> wrote:
>> Hey,
>>
>> On 12-08-15 14:35, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12-08-15 14:23, Michal Suchanek wrote:
>>>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>>>> automatic hardware controlled clock gating on the mmc interface.
>>>>
>>>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> In general this looks good, but I wonder how intensively this has
>>> been tested ?
>> It doesn't matter actually, it took some time longer, but the mmc still
>> craps out even with Michal's 3 patches. I'll revert hans's earlier patch
>> again and do a bit more extensive testing.
> Does the oclk switch timeout even after 750ms?
>
> In some earlier tests I tried to enable/disable the clock repeatedly
> when it failed but it seemed to have little effect on the total time
> it took to disable the clock in the end.
>
> Maybe it would be worh trying to set the timeout to some insanely long
> value and test stability with that. I picked 750 as around twice the
> maximum time it ever took on my board.
>
> Thanks
>
> Michal
>
