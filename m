From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Wed, 22 Jun 2011 11:38:41 +0200
Message-ID: <BANLkTi=udZv3g-jB+FBWyaXqhQie3B2EaA@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-3-git-send-email-per.forlin@linaro.org>
	<BANLkTikqeKg=Mr9BxVYL7x=9k_jzGeLnQQ@mail.gmail.com>
	<BANLkTi=GT=1u0YEtUaJre24BOhRyDNGUSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <BANLkTi=GT=1u0YEtUaJre24BOhRyDNGUSg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Nickolay Nickolaev <nicknickolaev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 22 June 2011 11:31, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 22 June 2011 10:51, Nickolay Nickolaev <nicknickolaev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hello,
>>
>> this one's causing me compilation trouble troubles when CONFIG_DMA_ENGIN=
E is
>> not defined.
>>
> I don't see this issue when I compile the kernel for a Pandaboard
> without CONFIG_DMA_ENGINE being set. Could you please clarify or show
> me your build log?
> I don't see how host->next_data.cookie is connected to DMA_ENGINE.
>
I think you are referring to the mmci-patch. I'll fix the issue in mmci.

>> On Wed, Jun 22, 2011 at 2:38 AM, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrot=
e:
>>>
>>> @@ -2077,6 +2155,7 @@ static int __init omap_hsmmc_probe(struct
>>> platform_device *pdev)
>>> =A0 =A0 =A0 =A0host->mapbase =A0 =3D res->start;
>>> =A0 =A0 =A0 =A0host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4K);
>>> =A0 =A0 =A0 =A0host->power_mode =3D MMC_POWER_OFF;
>>> + =A0 =A0 =A0 host->next_data.cookie =3D 1;
>>>
>>> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
>>> =A0 =A0 =A0 =A0INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>>> --
>>> 1.7.4.1
>>>
>>>
>>
>> Maybe we can wrap it in a function as the others.
>>
>> regards,
>> Nikolay Nikolaev
>>
>
> Regards,
> Per
>
