From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages during reset
Date: Wed, 14 Feb 2018 08:50:16 -0800
Message-ID: <FAD84DC4-510C-4AED-A310-A8F6D6FB4B5D@gmail.com>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de><97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de> <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Suchanek <msuchanek@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On February 14, 2018 6:38:58 AM PST, Michal Suchanek <msuchanek@suse=2Ede> =
wrote:
>The previous patch does reset during hardware error so make the reset
>progress more visible=2E

Based on your previous email it looks like this can happen quite frequentl=
y so we might be spamming the kernel log with such reset messages=2E Turnin=
g this into a debug print would not be great either, how about a custom sys=
fs attribute counting the number of times a reset was done?

We should ideally root cause this but I am sure we can=2E

--=20
Florian
