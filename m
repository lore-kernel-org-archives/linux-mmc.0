From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: Re: [PATCH v9 3/3] mmc: sdhci-msm: Add platform_execute_tunning implementation
Date: Sat, 01 Mar 2014 00:29:53 +0200
Message-ID: <53110DE1.6070204@mm-sol.com>
References: <1393586675-14628-1-git-send-email-gdjakov@mm-sol.com> <1393586675-14628-4-git-send-email-gdjakov@mm-sol.com> <20140228205119.GJ7308@joshc.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228205119.GJ7308@joshc.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org, grant.likely@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 28.02.14, 22:51, Josh Cartwright wrote:
[..]
>> +		sg_init_one(&sg, data_buf, sizeof(data_buf));
>> +		memset(data_buf, 0, sizeof(data_buf));
>> +		mmc_wait_for_req(mmc, &mrq);
>> +
>> +		if (!cmd.error && !data.error &&
>> +		    !memcmp(data_buf, tuning_block_pattern, sizeof(data_buf))) {
>=20
> This memcmp is broken, sizeof(data_buf) is likely not what you want,
> maybe you want 'size'?  Same thing for sg_init_one()/memset() above.
>=20
> From sparse:
>=20
> drivers/mmc/host/sdhci-msm.c: In function =C3=A2=E2=82=AC=CB=9Csdhci_=
msm_execute_tuning=C3=A2=E2=82=AC=E2=84=A2:
> drivers/mmc/host/sdhci-msm.c:461:53: warning: argument to =C3=A2=E2=82=
=AC=CB=9Csizeof=C3=A2=E2=82=AC=E2=84=A2 in =C3=A2=E2=82=AC=CB=9Cmemcmp=C3=
=A2=E2=82=AC=E2=84=A2 call is the same expression as the first source; =
did you mean to provide an explicit length? [-Wsizeof-pointer-memaccess=
]
>        !memcmp(data_buf, tuning_block_pattern, sizeof(data_buf))) {
>=20

Nice catch, Josh! Thanks for reviewing!

BR,
Georgi
