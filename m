From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device
 tree support
Date: Wed, 28 Mar 2012 20:15:35 -0700
Message-ID: <4F73D3D7.1010202@samsung.com>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <003401cce730$baf979a0$30ec6ce0$%kim@samsung.com> <m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com> <m239abgc32.fsf@bob.laptop.org> <00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com> <m2vcn0496y.fsf@bob.laptop.org> <87k426vy9r.fsf@laptop.org> <20120328095450.GA23005@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120328095450.GA23005@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, 'Thomas Abraham' <thomas.abraham@linaro.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, 'Olof Johansson' <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On 03/28/12 02:54, Mark Brown wrote:
> On Tue, Mar 27, 2012 at 11:50:24AM -0400, Chris Ball wrote:
>> On Tue, Feb 21 2012, Chris Ball wrote:
>>> On Tue, Feb 21 2012, Kukjin Kim wrote:
>
>>>> I created topic branch for this we talked. You can pull that following:
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>>>> v3.4-for-cjb
>
>>>> If any problems, please kindly let me know.
>
>>> Pushed to mmc-next, thanks.  (I'm expecting that you'll do the merge
>>> to Linus.)
>
>> I was expecting you to merge these patches, but they aren't in the
>> arm-soc tree and haven't been sent to Linus,

(Cc'ed Olof and Arnd)

Chris, Yeah, it is not in arm-soc tree now. Because I sent a pull 
request of samsung-mmc which is including this v3.4-for-cjb but Olof 
wanted to merge only arch/arm/ part for samsung mmc because they are not 
unrelated to the branch, v3.4-for-cjb sent to you. Since I thought the 
branch would be sent to upstream via your tree and you were included in 
the mailing loop, I agreed. So there is no it in arm-soc.

>> and we're in the last few
>> days of the merge window.
>
Yeah...it means not closed yet ;)

>> As a result I'm dropping this tree -- and all of the patches that I
>> have on top of it -- from mmc-next so that I can get a pull request
>> out.  This means that I'm dropping:
>
Hmm, I think, if you're ok, you can send a second pull request to Linus 
for it and actually, it is in linux-next for a long time via mmc and 
samsung tree.

Note, please don't rebase it because its resolution for conflicts is in 
linux-next and I think Linus will use it when happens conflicts...Or I 
can provide new tree on top of latest mainline. But I'm not sure about 
latter.

> If they're already in your tree why not just send them to Linus?  Given
> that everything's in git I don't understand why you'd need Kukjin to
> push them separately or what the benefit of that would be?
>
Yes, I already agreed its merging in the mmc tree :)

> This is all extremely frustrating fromm the contributor point of view.

If any my effort is required, feel free to contact me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
