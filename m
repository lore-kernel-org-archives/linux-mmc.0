From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/7] mmc: dw_mmc: add samsung exynos5250 specific
 extentions
Date: Thu, 10 May 2012 16:25:15 +0530
Message-ID: <CAJuYYwS=qExrAjG1kgd=tPYL0pQeP+7xE1SuMaP+do-Eg3D7eQ@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-5-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2XBinh=XAVnt3EnWrEqeTKz34d9yB6wfiuF-J-Se_Q__Q@mail.gmail.com>
 <4FA0E706.8060700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4FA0E706.8060700-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2 May 2012 13:19, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On 05/02/2012 04:01 PM, Kyungmin Park wrote:
>
>> Hi,
>>
>> On 5/2/12, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> The instantiation of the Synopsis Designware controller on Exynos5250
>>> include extension for SDR and DDR specific tx/rx phase shift timing
>>> and CIU internal divider. In addition to that, the option to skip the
>>> command hold stage is also introduced. Add support for these Exynos5250
>>> specfic extenstions.

[...]

>>> @@ -265,6 +266,10 @@ static u32 dw_mci_prepare_command(struct mmc_host =
*mmc,
>>> struct mmc_command *cmd)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmdr |=3D SDMMC_CMD_DAT_WR;
>>> =A0 =A0 =A0}
>>>
>>> + =A0 =A0if (slot->host->drv_data->ctrl_type =3D=3D DW_MCI_TYPE_EXYNOS5=
250)
>>> + =A0 =A0 =A0 =A0 =A0 =A0if (SDMMC_CLKSEL_GET_SELCLK_DRV(mci_readl(slot=
->host, CLKSEL)))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmdr |=3D SDMMC_USE_HOLD_REG;
>> Some other board, custom SOC also can use this HOLD register. So it's
>> not EXYNOS5250 specific one. I think we introduce the more generic
>> quirks for this instead of SOC specific.
>
> One more, I think that also need to check the IMPLEMENT_HOLD_REG bit in H=
CON register.
> It has dependency with that.

The above code is specific to Exynos5250 and hence it is not required
to check the IMPLEMENT_HOLD_REG bit in HCON register. On Exynos5250,
the hold register is implemented and available.


> As Mr.Park is mentioned, this register is clock phasing.
> In spec, card is enumerated in SDR12 or SDR25 mode, the application must =
program the use_hold_reg.

Exynos5250 hardware manual specifies additional restrictions on the
use of hold register. The above code checks for those restrictions and
programs the USE_HOLD_REG accordingly. Please let me know if there is
any condition that is not handled by the above code.

Thanks,
Thomas.

>
> Best Regards,
> Jaehoon Chung
>
