Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4787C00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 09:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiHOJvV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbiHOJvN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 05:51:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70125.outbound.protection.outlook.com [40.107.7.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7479313D71
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 02:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0xspKJLXl5NmB560P4yd1bSSahPBa6IUvvcT+mDqr6aTxhPMb3NBwcs8AVlsxpEjC6xCQKn/QCKkEQsvum4OKa9nuyJdtSpUFRvAWv0UHsDQ6c5qfJ5Pma8JYZ85YzsWTnHcf+eXgYxYiqVYbOCwI1J9D7FwVkogL6DqmTGCp4I2Kekkx+/yfmijr/tpVCR0uQ18jPlHGOHy8xpuPj8gpjKKaTHcLdw9BD2U6LIDvBUDsQhjHRk5RVKu+axcEbNDwh1l3+NhAzpmZ/BlC3+oGJ4+pWnScjimiPgaDKHF8kaKimfit+Eizmc835BkykY9u61E1HN2CSPCPbakJuPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+50Fof9ueusF9ZgHhNQH32TFT7YymdzArIKkNGKOjzc=;
 b=LY665krkX5n8oBoFy0S4MRK5O2hObAvNEFBvK0smv7O7bT8YHmje7sv8/dmmpnqpvFUna6iOdrDoiL17KHeVh/X+Yn51Tyq/fZh04YLmdKN7NN6BA0HsdP+FovECEeuO1xvWHNqrH05Fz6I9J8nFJXlwOg8Jtf0icktcY6c8f4tqn/vJ8HafjNNV/9pjp+FrP0zzvceOIQS3vOzQy4QH3phyTQYT99TlkOGq7Rhzotdrj66jKQBFcgAKDOZZRqRdB671VOoMULmWHtYWmZ75ApD1PXocoyynW4rSjKAULOAAHjEqxIT6q86Aj/fnrGXiMJ3/rKyDaQm8Vrl7Ss5TVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+50Fof9ueusF9ZgHhNQH32TFT7YymdzArIKkNGKOjzc=;
 b=SvYidSGXlwTBz+pnP6SV7o4R4kwRPzj9ZKTQ/6hWYdLt6lsoTzsog29GrNEUqGXBw3HVAOfI/qWe+/0wSMLFqSHYz4q+IZoOOAMYkNsCLwfVavfAE0Na4du+kqH69HFbYvKMkQkCSnHiL9sAVzv4fcXNu+uQlu/cH/Co0jKIsPI=
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 (2603:10a6:203:4e::11) by AM6PR0702MB3782.eurprd07.prod.outlook.com
 (2603:10a6:209:6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Mon, 15 Aug
 2022 09:51:04 +0000
Received: from AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640]) by AM5PR0701MB2964.eurprd07.prod.outlook.com
 ([fe80::542a:5d98:f0f4:3640%7]) with mapi id 15.20.5546.014; Mon, 15 Aug 2022
 09:51:04 +0000
From:   "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Rossler, Jakob (Nokia - DE/Ulm)" <jakob.rossler@nokia.com>,
        "Heinonen, Aarne (Nokia - FI/Espoo)" <aarne.heinonen@nokia.com>
Subject: RE: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Topic: [PATCH] mmc-utils: correct and clean up the file handling
Thread-Index: AdiK+e63vfHiFbPsQZCmC+FOzGq/7QAPwi0AABQpUuABmc8nMAACAULgAlKINPAAMpvpoAUetmXQ
Date:   Mon, 15 Aug 2022 09:51:04 +0000
Message-ID: <AM5PR0701MB296429322BA0EEB2CE0B23FBEF689@AM5PR0701MB2964.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB2964B04050F05216BDFC638AEFBB9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <AM5PR0701MB2964D76967437E61EF42731DEF839@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65750D9A332093DBA5B30BDAFC839@DM6PR04MB6575.namprd04.prod.outlook.com>
 <AM5PR0701MB29641DB9207CDDD1DB273075EF8F9@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65759D709D6C45AFD03EB4B1FC8E9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4465603-8669-4b45-6e42-08da7ea3ab09
x-ms-traffictypediagnostic: AM6PR0702MB3782:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FK8JbCUuBw3JHXdhaJapftaKqD1KPI0ufI0KPR4hgTUZlgVZLZ5+FCATuNlLTXvKqTTdSNe4buSl7yd2zleSbOGWFXdnZzHgLZc29EgjuYGlwInXn99nGvpdO8NXeq//ClwnvGnh4wY6upgqgEgiuM23bS/0krcSL/Er+M/JX9wdFc3LcBm2PJF5GTSygHidXw2JnI7C+nfrL78RuXLrk5oeohbMSy1hAB8TE62pS1GTl3cQU9HhuqQzGWxruxUcapJvuzCj32lDlMMNqXh4v/6Sjhg3MYcF9PCjdNHkm5hUnV8eoQslFVvThfgKihK6LH+l5BMLbqokE8CaDaFN7BO8TPHR+2qa7GsDskIe8S8g5TiSrHehjlXjxoXT6XASSdAWTMNqQC7qDfGUDyQksYEqx9o2AUMqMvaLPFaEpkWTfBcSGx+z1KNvo2uu2/3yUDeK/T4+W3psAXWVuIsRrvYkbp21SMPLtKMUoPdlIQyfW8zDAK4cmQq3hO0TFOioyFCNh7VH/mVAPyWOJM33RP3grSTurlPkp+FbQOhtZYAC3assJ/FZCVyx0DkFK4FInZntJh9t+67eVtG9m/S9pns8LXk3e4/wLrEJdMVNKhvlpaJPMyAn2eMZlnk6OIkv6ja7QvlgUlC/IgMFQP4YmvbzJcgSe+UuQeMAZ02WpB/nrn/ki73F0va+Q0f8EOk6wuBccDDkU2eVqTSKdQLclDbzns+IsFD4ek2KLKwFYVxeWdyvK2lhKK6TMauAZDvXVpCDF5tStdC7tq7bnWAfKNMJMV7Q0umIsGW7tiiWlvkXdT5SDn+ANk1MB91T8ep3I2aLrG/kggFxqqZtLmQo/peAzrv7V1Zse6ZSbEGkngY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR0701MB2964.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(41300700001)(478600001)(26005)(55016003)(9686003)(86362001)(6506007)(7696005)(82960400001)(71200400001)(122000001)(38070700005)(38100700002)(186003)(107886003)(83380400001)(66446008)(66476007)(66556008)(8936002)(66946007)(52536014)(316002)(64756008)(5660300002)(8676002)(4326008)(76116006)(2906002)(110136005)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?7AUTuK5lW/muuIWb7cwmcGumRJK8KjqK2rP5ssB7Gn4/VI+PIyRtf8EsXF?=
 =?iso-8859-2?Q?7aXMAAS3mJG9LMWy18rfdJbaO+/lUTo/IZiz3gqP8RmcJbgnuIJXDMOru6?=
 =?iso-8859-2?Q?W/jLpOQnsgn5/AyrY2ReoXo2CLH9Meyc83k+8/NGVkrslZ7GTdC+SNvb2t?=
 =?iso-8859-2?Q?blgu5sgRo8s62FWLCJcTA30H0ILo5Hfs24NVu+qQ5AmY6oM/nOHuvDry/U?=
 =?iso-8859-2?Q?l7hIVEoZivGxEvpa4JKUgDxx+Zr7JD1vmIeJdXQKaKBTnEJUxgvft81UBs?=
 =?iso-8859-2?Q?MSmIZTXs1wuDblbV7m9v+ZFR1sXHyzNBt2GntH7LxNOA4Ny5acd70ue+cD?=
 =?iso-8859-2?Q?iIZU+JeAaXhJbRmlioucvvzWmVfMPLKAieOSwj8zmok7LGcc0LgagYMczB?=
 =?iso-8859-2?Q?I1TN76yTlXdqNknzEEASsb8OVDdS6mmhfkERK0fe9bcyXjhWDyIhYmYuNA?=
 =?iso-8859-2?Q?tQ/hdP5vO7yF6xjJ1i8qRcPt+36YHyuKhWhslXsyvpeoFl5Z0sV90OSN1G?=
 =?iso-8859-2?Q?2wWI5cY+/ePpYuuT9MMiq56xtpAcZlxKyd/8n+wra4MP4XaIRNSplN+TPD?=
 =?iso-8859-2?Q?G7gSV/YgQCbFfelf4OxrW8SoGil4Kz9FkcPR/ZfnMBogciG72ZBzouVeUj?=
 =?iso-8859-2?Q?sHN1fgPFW29cgr69nS1fFW3ORIcRMj3Y2/p19TC0/0ID7jftIeqsXpNwle?=
 =?iso-8859-2?Q?VlaWBbE9qyj9HiHz+rLbgqmmWIMnZ1qC2W2ct2XNC3IvMzifY8jznQH1Xj?=
 =?iso-8859-2?Q?TXUgHN4UozBF7S0OaXhRokXJxlLqE9L6xEKadaN6MCYpLzoDpBgN4OEdex?=
 =?iso-8859-2?Q?QcJ3f0Xw/cL/QIRbX3fSvZ2L7kIKJP0V+/Si7IvUPv4c5hQIabggl4z947?=
 =?iso-8859-2?Q?60Chsi+gwls4eLdMgPmrneCoSjpSVvJd1AG9gDuAu73ARMRR8yyoSxABIB?=
 =?iso-8859-2?Q?TQK36TsYijY2stPY9WV5Z7FJzUS29x1bUlbsXBcJiaJPqd9Mj7gLGwRIOr?=
 =?iso-8859-2?Q?E2G0q/8LiL9quHcjyrMYM8VnIg7beYdjoVKWHX5dpuqqkYrWqZsc/mhZ9F?=
 =?iso-8859-2?Q?e2Ug3apb6naTPYKGfPSGSoS2Ja9ne/AJoIJBHSpEZ0qi0C2J3IGwc5Qob2?=
 =?iso-8859-2?Q?HfmudGjrHAEybpaVPo46/UvOhfaOz5VxhfZTWjKbwBe+FxgLVfb0Br8TPM?=
 =?iso-8859-2?Q?dQr/mreQK25rkHaogn18gsKPcbgF5O2RaDwwu2e7+2CNI0/U+wuQ/ayDFE?=
 =?iso-8859-2?Q?/a9Wq6XwqxnOp0uO9YtCS3wS4rngMquBY+MQmDxMN/zMMYpe5e1hzNz6ru?=
 =?iso-8859-2?Q?Z8/LaFTK9LFWfpbRmmahF3nrdYjcYstiV+heaDUJVRYVQaDJjereMsFsBo?=
 =?iso-8859-2?Q?DgqBIjHQYhYPxpJ6rjXOJ8L5MwkQXbeosSUjcGI8oCRNRLJXqpjyLSxUkU?=
 =?iso-8859-2?Q?menonwAJB42G1Z3+Xh6smmkaJJSKxmExzMtbt6Zex6SmtMMW6HOBHkXUJW?=
 =?iso-8859-2?Q?K20iHc7ZEi7ZwKlb68pp181hy0Ac0BaqMh+X/CFG1fLfx8smISLt/GdtbQ?=
 =?iso-8859-2?Q?MCe/APbxa0XfoE1Fpy7MiHsu3DPtFULQNERrRfHEIvPg0F8zbg9qoqMa+o?=
 =?iso-8859-2?Q?8sCeeaB27qAeT6/xe99NInsFzEAzZXRa7A?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR0701MB2964.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4465603-8669-4b45-6e42-08da7ea3ab09
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 09:51:04.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVdTThSm9Z+uOFfRiucWe7kclly/q03XZhTa8KQdMvZEhWkCUVdX/DBMdIJCSW8nOSUhUMdQrWy/8Qa5kv6Wxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3782
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi everyone,

Comments are in-line bellow.

>Bruni hi,
>Thank you for your patch.
>
>> Hi everyone,
>>=20
>> Here is the rebased patch.
>>=20
>> Add the check if the whole firmware was loaded.
>> Cleaned up the leftovers of handling the file in chunks.
>>=20
>> Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
>>=20
>> ---
>>  mmc_cmds.c | 67=20
>> +++++++++++++++++++++++++++---------------------------
>>  1 file changed, 33 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 8d7910e..d017b64 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -2812,7 +2812,6 @@ int do_ffu(int nargs, char **argv)
>>         __u8 *buf =3D NULL;
>>         __u32 arg;
>>         off_t fw_size;
>> -       ssize_t chunk_size;
>>         char *device;
>>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>>=20
>> @@ -2926,45 +2925,45 @@ int do_ffu(int nargs, char **argv)
>>         multi_cmd->cmds[3].flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B |=20
>> MMC_CMD_AC;
>>         multi_cmd->cmds[3].write_flag =3D 1;
>>=20
>> -do_retry:
>> -       /* read firmware chunk */
>> +       /* read firmware */
>>         lseek(img_fd, 0, SEEK_SET);
>> -       chunk_size =3D read(img_fd, buf, fw_size);
>> +       if (read(img_fd, buf, fw_size) !=3D fw_size) {
>> +               fprintf(stderr, "Could not read the whole firmware file\=
n");
>> +               ret =3D -ENOSPC;
>No space left?
>
Here I would propose to use perror instead of fprintf - something like:
	perror("Could not read the firmware file: ");
This will also propagate the errno from read.

>> +               goto out;
>> +       }
>>=20
>> -       if (chunk_size > 0) {
>> -               /* send ioctl with multi-cmd */
>> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>> +do_retry:
>> +       /* send ioctl with multi-cmd */
>> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
>>=20
>> -               if (ret) {
>> -                       perror("Multi-cmd ioctl");
>> -                       /* In case multi-cmd ioctl failed before exiting=
 from ffu mode */
>> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>> -                       goto out;
>> -               }
>> +       if (ret) {
>> +               perror("Multi-cmd ioctl");
>> +               /* In case multi-cmd ioctl failed before exiting from ff=
u mode */
>> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
>> +               goto out;
>> +       }
>Why do we need this hack?
>Why would the last command is prone to fail?
>If there is no good reason - Lets remove this hack - as a 2nd patch in thi=
s series.
If I assume correctly you refer to repetition of third command after a fail=
ure.
This was left as-is since I understood that first and second command can fa=
il, but the device
should not remain in upgrade mode in case of failure.

>
>>=20
>> -               ret =3D read_extcsd(dev_fd, ext_csd);
>> -               if (ret) {
>> -                       fprintf(stderr, "Could not read EXT_CSD from %s\=
n", device);
>> -                       goto out;
>> -               }
>> +       ret =3D read_extcsd(dev_fd, ext_csd);
>> +       if (ret) {
>> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devi=
ce);
>> +               goto out;
>> +       }
>>=20
>> -               /* Test if we need to restart the download */
>> -               sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
>> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] <<=
 8 |
>> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] <<=
 16 |
>> -                               ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] <<=
 24;
>> -               /* By spec, host should re-start download from the first=
 sector if
>> sect_done is 0 */
>> -               if (sect_done =3D=3D 0) {
>> -                       if (retry > 0) {
>> -                               retry--;
>> -                               fprintf(stderr, "Programming failed. Ret=
rying... (%d)\n",
>> retry);
>> -                               goto do_retry;
>> -                       }
>> -                       fprintf(stderr, "Programming failed! Aborting...=
\n");
>> -                       goto out;
>> -               } else {
>> -                       fprintf(stderr, "Programmed %d/%jd bytes\r", sec=
t_done *
>> sect_size, (intmax_t)fw_size);
>> +       /* Test if we need to restart the download */
>> +       sect_done =3D ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
>> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
>> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
>> +                       ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
>> +       /* By spec, host should re-start download from the first=20
>> + sector if
>> sect_done is 0 */
>Can we use here be32toh or get_unaligned_be32 or something instead?
Tried to look into it - none of the functions fit the need, input must be a=
n int.
Best I can offer is to write a macro - something along the lines:
	#define le32toh_array(p) (p | *(&p+1) << 8 | *(&p+2) << 16 | *(&p+3) << 24=
 )
	sect_done =3D le32toh_array(ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);

>
>> +       if (sect_done =3D=3D 0) {
>> +               if (retry > 0) {
>If (retry--)
Agreed - will be done in v2.

>
>> +                       retry--;
>> +                       fprintf(stderr, "Programming failed. Retrying...=
 (%d)\n", retry);
>> +                       goto do_retry;
>>                 }
>> +               fprintf(stderr, "Programming failed! Aborting...\n");
>> +               goto out;
>>         }
>>=20
>>         if ((sect_done * sect_size) =3D=3D fw_size) {
>>=20
>> Best regards,
>> Bruno Mati=E6
>
>Thanks,
>Avri
>
