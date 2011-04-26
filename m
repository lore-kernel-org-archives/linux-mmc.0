From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/12] mmc: add none blocking mmc request function
Date: Tue, 26 Apr 2011 16:22:12 +0200
Message-ID: <BANLkTinVL7NJpgGF0KZAdmqgyu2pXyKFkA@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-2-git-send-email-per.forlin@linaro.org>
	<4DA81F42.3070208@csr.com>
	<BANLkTimaTe0qD5sbEJj88YRv2DZv=1oxTQ@mail.gmail.com>
	<4DB6C89F.10903@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4DB6C89F.10903-kQvG35nSl+M@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: David Vrabel <david.vrabel-kQvG35nSl+M@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 26 April 2011 15:29, David Vrabel <david.vrabel-kQvG35nSl+M@public.gmane.org> wrote:
> On 20/04/11 08:17, Per Forlin wrote:
>>
>>> Using a MMC request queue has other benefits -- it allows multiple users
>>> without having to claim/release the host. =A0This would be useful for
>>> (especially multi-function) SDIO.
>>
>> You mean claim and release would be done only within the mmc core. The
>> timed saved here would equal the time it takes to release and claim
>> the host.
>> Claim and release can also be used for power management to indicate if
>> any client is using the host, if not the power can be switched off.
>
> Isn't there a separate runtime power management API that different from
> claim/release?
>
I misunderstood. I thought you meant that the claim() and release()
were not needed if having an internal request queue in core.c.
Please discard my comment.

>> I just want to make sure I understand the multi-function SDIO case, I
>> haven't done any work with SDIO.
>> Can the SDIO functions compete over the same claim_host at the same time?
>> Example: if function 1 claims the host, function 2 and function 3 also
>> want to claim the host but have to wait for function 1 to release the
>> host.
>
> This is the case. =A0 Each function driver has to claim exclusive access
> to the host.
>
>> What is the extra benefit of having the internal request queue for
>> multi function SDIO?
>
> It reduces the delays between commands if multiple drivers are sending
> commands. =A0I estimated performance improvements with 2-3% from just
> removing the need to claim/release in one particular SDIO function
> driver. =A0Performance improvements for multi-function cards would be a
> bit more (5% perhaps?).
>
Your estimates are promising.

> The more important benefit is the simplification of the API.
I agree. I will make a prototype for this. I don't think I will be
able to find time for this until middle of May. I let know you when I
have patches.

>
> David
Thanks,
Per
