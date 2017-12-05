From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 10/22] mmc: tmio: support IP-builtin card detection logic
Date: Wed, 6 Dec 2017 00:03:29 +0900
Message-ID: <CAK7LNATeFZMVocscnfkYTU=5=dyRSNrrgVoh0rEvLyQvku9VSQ@mail.gmail.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-11-git-send-email-yamada.masahiro@socionext.com> <20171204151320.4ypa2y5r335hcg7j@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171204151320.4ypa2y5r335hcg7j@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

2017-12-05 0:13 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>> +static int tmio_mmc_get_cd(struct mmc_host *mmc)
>> +{
>> +     struct tmio_mmc_host *host = mmc_priv(mmc);
>> +     int ret;
>> +
>> +     ret = mmc_gpio_get_cd(mmc);
>> +     if (ret >= 0)
>> +             return ret;
>> +
>> +     return !!(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
>> +                                                     TMIO_STAT_SIGSTATE);
>> +}


I just followed tmio_mmc_get_ro() implementation.

If we do not care the symmetry between _get_ro() and _get_cd() hooks,
yes, your suggestion makes sense.



> I wonder if we shouldn't do something like:
>
>         if (mmc_can_gpio_cd())
>                 return mmc_gpio_get_cd()
>         else
>                 return !!(sd_ctrl_read16_and_16_as_32...)
>
> If we have a GPIO CD defined, I think we want the value of
> mmc_gpio_get_cd() in all cases. It makes clearer that this is an
> 'either-or' case and not a fallback mechanism.
>


Another possibility would select this in _probe().
We would need to evaluate mmc_can_gpio_cd() only once when probing.

I will follow your suggestion, though.
Either way is fine with me.



static int tmio_mmc_get_cd(struct mmc_host *mmc)
{
       struct tmio_mmc_host *host = mmc_priv(mmc);

       return !!(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
                                                TMIO_STAT_SIGSTATE);
}

static const struct mmc_host_ops tmio_mmc_ops = {
      ...
      .get_cd      = tmio_mmc_get_cd,
      ...
};

int tmio_mmc_host_probe( ... )
{
      ....

      /* replace get_cd hook when we use GPIO for card detection */
      if (mmc_can_gpio_cd(mmc))
                _host->ops.get_cd = mmc_gpio_get_cd;


}





-- 
Best Regards
Masahiro Yamada
