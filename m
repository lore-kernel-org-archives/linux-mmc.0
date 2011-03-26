From: Grant Grundler <grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] tegra/mmc: add pm_flags
Date: Fri, 25 Mar 2011 17:57:34 -0700
Message-ID: <AANLkTimSe6ec7p32+eJFk25TTHeK5vTsJzo6wMrcrEEz@mail.gmail.com>
References: <20110326000712.DD5D3208182@grundler.mtv.corp.google.com>
	<m3mxkik8yi.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3mxkik8yi.fsf-0VGQAjvlmrQzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vrao-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 25, 2011 at 5:43 PM, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> wrote:
> Hi Grant,
>
> On Fri, Mar 25 2011, Grant Grundler wrote:
>> Enable fast bcm4329 WIFI suspend/resume on Tegra2 board.
>>
>> This part allows the mach-tegra support tell the tegra MMC host cont=
roller
>> to NOT turn off power for the MMC controller the WIFI part lives beh=
ind.
>> Thus bcm4329 firmware doesn't need to be reloaded.
>>
>> Signed-off-by: Venkat Rao <vrao@broadcom>
>> Tested-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Reviewed-by: Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> One more thing -- who wrote this patch? =C2=A0If Venkat, it should ha=
ve a:
>
> From: Venkat Rao <vrao-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Yes, Venkat wrote it which is why it has his S-o-b line listed first.

> line in either the mail headers or the message body. =C2=A0If you, it=
 should
> have your S-o-b. =C2=A0The way you've sent it tells Git that you wrot=
e the
> patch.

Sorry about that. Can you please add the "From" line you've shown
above since it's clearly Venkat's.

thanks!
grant
