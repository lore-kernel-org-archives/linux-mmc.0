From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
Date: Tue, 31 Jul 2018 13:27:38 -0700
Message-ID: <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
References: <20180712195937.GA36007@beast> <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 16, 2018 at 3:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
> On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
>> Looks like the adjusted syntax wasn't fully build tested. This fixes
>> failures with powerpc builds:
>>
>> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=
=80=99:
>> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 be=
fore =E2=80=98;=E2=80=99 token
>>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>>                                                    ^
>> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or =
=E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>>  }
>>  ^
>>
>> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Thanks, applied for fixes!

I just checked again, and while I see this in linux-next, I would
expect this to be in 4.18, since this fixes a 4.18-introduced build
failure for some PPC configurations. Can this please be included in
4.18?

Thanks!

-Kees

>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/host/mxcmmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> index 75f781c11e89..de4e6e5bf304 100644
>> --- a/drivers/mmc/host/mxcmmc.c
>> +++ b/drivers/mmc/host/mxcmmc.c
>> @@ -293,9 +293,10 @@ static void mxcmci_swap_buffers(struct mmc_data *da=
ta)
>>         int i;
>>
>>         for_each_sg(data->sg, sg, data->sg_len, i) {
>> -               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>> +               void *buf =3D kmap_atomic(sg_page(sg) + sg->offset);
>>                 buffer_swap32(buf, sg->length);
>>                 kunmap_atomic(buf);
>> +       }
>>  }
>>  #else
>>  static inline void mxcmci_swap_buffers(struct mmc_data *data) {}
>> --
>> 2.17.1
>>
>>
>> --
>> Kees Cook
>> Pixel Security



--=20
Kees Cook
Pixel Security
