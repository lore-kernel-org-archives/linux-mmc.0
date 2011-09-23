From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V4] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Fri, 23 Sep 2011 20:27:03 +0530
Message-ID: <CAGxe1ZEz2MNzK1dA-5xJQrp3hq4vOw+wGrCg4Cccu_dtq888GA@mail.gmail.com>
References: <1316788353-11411-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2pqirxr0a.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <m2pqirxr0a.fsf@bob.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On 23 September 2011 20:09, Chris Ball <cjb@laptop.org> wrote:
> Hi Girish,
>
> On Fri, Sep 23 2011, Girish K S wrote:
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Voltage range not supporte=
d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"for power class.\n=
", mmc_hostname(host));
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>
> I suggested replacing your BUG(); here with a return, but you just ha=
ve
> a break here. =A0Is having the function continue in this case intenti=
onal?
sorry for that.
will update with a return -EBADMSG
>
>> +
>> + =A0 =A0 pwrclass_val =3D ext_csd[index];
>> +
>> + =A0 =A0 if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WID=
TH_8))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D (pwrclass_val & EXT_CSD_P=
WR_CL_8BIT_MASK) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PW=
R_CL_8BIT_SHIFT;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D (pwrclass_val & EXT_CSD_P=
WR_CL_4BIT_MASK) >>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PW=
R_CL_4BIT_SHIFT;
>> +
>> + =A0 =A0 /* If the power class is different from the default value =
*/
>> + =A0 =A0 if (pwrclass_val > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD=
_POWER_CLASS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrclas=
s_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return err;
>> +}
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
